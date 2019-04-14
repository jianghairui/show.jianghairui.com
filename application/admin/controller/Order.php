<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2019/4/14
 * Time: 13:20
 */
namespace app\admin\controller;

use think\Db;
class Order extends Common {

    public function goodsList() {
        $param['search'] = input('param.search');
        $param['cate_id'] = input('param.cate_id');
        $param['pcate_id'] = input('param.pcate_id');
        $param['sort'] = input('param.sort');
        $page['query'] = http_build_query(input('param.'));

        $curr_page = input('param.page',1);
        $perpage = input('param.perpage',10);
        $where = [
            ['g.status','=',1],
            ['g.del','=',0],
            ['g.stock','>',0]
        ];
        $order = [];
        $child_list = [];
        if($param['search']) {
            $where[] = ['g.name|g.number','like',"%{$param['search']}%"];
        }
        if($param['sort'] == 1) {
            $where[] = ['g.hot','=',1];
        }
        if($param['sort'] == 2) {
            $where[] = ['g.is_new','=',1];
        }
        if($param['sort'] == 3) {
            $order = ['up_time'=>'DESC'];
        }

        try {
            if($param['pcate_id']) {
                $child_list = Db::table('mp_goods_cate')->where('pid',$param['pcate_id'])->select();
                if($param['cate_id']) {
                    $where[] = ['g.cate_id','=',$param['cate_id']];
                }else {
                    $cate_ids = Db::table('mp_goods_cate')->where('pid',$param['pcate_id'])->column('id');
                    $where[] = ['g.cate_id','in',$cate_ids];
                }
            }
            $count = Db::table('mp_goods')->alias('g')->where($where)->count();
            $cate_list = Db::table('mp_goods_cate')->where('pid',0)->select();
            $list = Db::table('mp_goods')->alias('g')
                ->join("mp_goods_cate c","g.cate_id=c.id","left")
                ->field("g.*,c.cate_name")
                ->order($order)
                ->where($where)->limit(($curr_page - 1)*$perpage,$perpage)->select();
        }catch (\Exception $e) {
            die('SQL错误: ' . $e->getMessage());
        }

        $page['count'] = $count;
        $page['curr'] = $curr_page;
        $page['totalPage'] = ceil($count/$perpage);
        $this->assign('list',$list);
        $this->assign('page',$page);
        $this->assign('cate_list',$cate_list);
        $this->assign('child_list',$child_list);
        $this->assign('cate_id',$param['cate_id']);
        $this->assign('pcate_id',$param['pcate_id']);
        $this->assign('sort',$param['sort']);
        return $this->fetch();
    }

    public function getCateList() {
        $pid = input('post.pid');
        $where = [
            ['pid','=',$pid]
        ];
        try {
            $list = Db::table('mp_goods_cate')->where($where)->select();
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax($list);
    }

    public function goodsDetail() {
        $id = input('param.id');
        $info = Db::table('mp_goods')->where('id','=',$id)->find();

        $cate = Db::table('mp_goods_cate')->where('id',$info['cate_id'])->find();

        $this->assign('info',$info);
        $this->assign('cate',$cate);
        return $this->fetch();
    }

    public function order() {
        $val['id'] = input('post.id');
        $val['num'] = input('post.num');
        $this->checkPost($val);
        if(!preg_match('/^\d{1,8}$/',$val['num']) || $val['num'] < 1) {
            return ajax('无效的下单数量',-1);
        }
        try {
            $where = [
                ['id','=',$val['id']],
                ['del','=',0],
                ['status','=',1]
            ];
            $goods = Db::table('mp_goods')->where($where)->find();
            if(!$goods) {
                return ajax('商品不存在或已下架',-1);
            }
            if($val['num'] > $goods['stock']) {
                return ajax('库存不足',-1);
            }
            $insert_data = [
                'uid' => session('admin_id'),
                'order_sn' => create_unique_number(''),
                'goods_id' => $val['id'],
                'num' => $val['num'],
                'total_price' => $goods['price'] * $val['num'],
                'unit_price' => $goods['price'],
                'create_time' => time(),
                'status' => 1
            ];
            Db::table('mp_order')->insert($insert_data);
            Db::table('mp_goods')->where($where)->setDec('stock',$val['num']);
        } catch(\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function orderList() {
        try {
            $param['search'] = input('param.search');
            $page['query'] = http_build_query(input('param.'));

            $curr_page = input('param.page',1);
            $perpage = input('param.perpage',10);
            $where = [
                ['o.uid','=',session('admin_id')]
            ];
            $order = ['create_time'=>'DESC'];
            if($param['search']) {
                $where[] = ['o.order_sn','like',"%{$param['search']}%"];
            }

            try {
                $count = Db::table('mp_order')->alias('o')->where($where)->count();
                $list = Db::table('mp_order')->alias('o')
                    ->join("mp_goods g","o.goods_id=g.id","left")
                    ->field("g.name,o.*")
                    ->order($order)
                    ->where($where)->limit(($curr_page - 1)*$perpage,$perpage)->select();
            }catch (\Exception $e) {
                die('SQL错误: ' . $e->getMessage());
            }

            $page['count'] = $count;
            $page['curr'] = $curr_page;
            $page['totalPage'] = ceil($count/$perpage);

        } catch(\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('list',$list);
        $this->assign('page',$page);
        return $this->fetch();
    }


}