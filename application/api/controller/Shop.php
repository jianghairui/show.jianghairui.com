<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2019/3/20
 * Time: 15:45
 */
namespace app\api\controller;

use think\Controller;
use think\Db;

class Shop extends Controller {

    public function index() {

        try {
            $slide = Db::table('mp_slideshow')->where('status',1)->select();

            $where = [
                ['g.status','=',1]
            ];
            $goods_list = Db::table('mp_goods')->alias('g')
                ->join("mp_goods_cate c","g.cate_id=c.id","left")
                ->field("g.*,c.cate_name")
                ->where($where)->select();
            $where = [
                ['g.status','=',1],
                ['g.hot','=',1]
            ];
            $hot_list = Db::table('mp_goods')->alias('g')
                ->join("mp_goods_cate c","g.cate_id=c.id","left")
                ->field("g.*,c.cate_name")
                ->where($where)->select();
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('slide',$slide);
        $this->assign('goods_list',$goods_list);
        $this->assign('hot_list',$hot_list);
        return $this->fetch();
    }


    public function detail() {
        $id = input('param.id');
        try {
            $info = Db::table('mp_goods')->alias('g')
                ->join("mp_goods_cate c","g.cate_id=c.id","left")
                ->field("g.*,c.cate_name")
                ->where('g.id',$id)->find();
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('info',$info);
        return $this->fetch();
    }

    public function cateList() {
        try {
            $map = [
                ['del','=',0],
                ['status','=',1]
            ];
            $list = Db::table('mp_goods_cate')->where($map)->select();
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        $list = $this->recursion($list,0);
        $this->assign('catelist',$list);
        return $this->fetch();
    }

    public function info() {
        $cate_id = input('param.cate_id',0);
        $act = input('param.act',1);
        $order = [];
        $where = [];
        $where[] = ['g.status','=',1];
        if($cate_id) {
            $where[] = ['g.cate_id','=',$cate_id];
        }
        if($act == 1) {
            $where[] = ['g.is_new','=',1];
        }
        if($act == 2) {
            $where[] = ['g.hot','=',1];
        }
        if($act == 3) {
            $order = ['g.up_time'=>'DESC'];
        }
        try {
            $cate_exist = Db::table('mp_goods_cate')->where('id',$cate_id)->find();
            $cate_name = $cate_exist['cate_name'];
            $pcate_name = Db::table('mp_goods_cate')->where('id',$cate_exist['pid'])->value('cate_name');
            $goods_list = Db::table('mp_goods')->alias('g')
                ->join("mp_goods_cate c","g.cate_id=c.id","left")
                ->where($where)
                ->order($order)
                ->field("g.*,c.cate_name")
                ->select();
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('goods_list',$goods_list);
        $this->assign('act',$act);
        $this->assign('cate_id',$cate_id);
        $this->assign('cate_name',$cate_name);
        $this->assign('pcate_name',$pcate_name);
        return $this->fetch();
    }















    private function recursion($array,$pid=0) {
        $to_array = [];
        foreach ($array as $v) {
            if($v['pid'] == $pid) {
                $v['child'] = $this->recursion($array,$v['id']);
                $to_array[] = $v;
            }
        }
        return $to_array;
    }

}