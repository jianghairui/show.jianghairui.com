<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2019/3/19
 * Time: 13:45
 */
namespace app\admin\controller;
use think\Db;
use think\facade\Request;

class Shop extends Common {

    public function goodsList() {
        $param['search'] = input('param.search');
        $param['cate_id'] = input('param.cate_id');
        $param['pcate_id'] = input('param.pcate_id');
        $param['sort'] = input('param.sort');
        $page['query'] = http_build_query(input('param.'));

        $curr_page = input('param.page',1);
        $perpage = input('param.perpage',10);
        $where = [];
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

    public function goodsAdd() {
        try {
            $list = Db::table('mp_goods_cate')->where('pid',0)->select();
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('list',$list);
        return $this->fetch();
    }

    public function goodsDetail() {
        $id = input('param.id');
        $info = Db::table('mp_goods')->where('id','=',$id)->find();

        $pid = Db::table('mp_goods_cate')->where('id',$info['cate_id'])->value('pid');

        $plist = Db::table('mp_goods_cate')->where('pid',0)->select();
        $list = Db::table('mp_goods_cate')->where('pid',$pid)->select();
        $this->assign('info',$info);
        $this->assign('plist',$plist);
        $this->assign('list',$list);
        $this->assign('pid',$pid);
        return $this->fetch();
    }

    public function goodsAddPost() {
        $val['name'] = input('post.name');
        $val['cate_id'] = input('post.cate_id');
        $val['status'] = input('post.status');
        $val['hot'] = input('post.hot');
        $val['number'] = input('post.number');
        $val['create_time'] = time();
        $val['up_time'] = input('post.up_time');
        $val['is_new'] = input('post.is_new');
        $val['price'] = input('post.price');
        $val['stock'] = input('post.stock');
        $this->checkPost($val);
        $val['detail'] = input('post.detail');

        $image = input('post.pic_url',[]);
        $image_array = [];
        if(is_array($image) && !empty($image)) {
            if(count($image) > 5) {
                return ajax('最多上传5张图片',-1);
            }
            foreach ($image as $v) {
                if(!file_exists($v)) {
                    return ajax('无效的图片路径',-1);
                }
            }
            foreach ($image as $v) {
                $image_array[] = $this->rename_file($v);
            }
        }else {
            return ajax('请上传图片',-1);
        }
        $val['pics'] = serialize($image_array);

        try {
            $res = Db::table('mp_goods')->insert($val);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        if($res) {
            return ajax([],1);
        }else {
            foreach ($image_array as $v) {
                @unlink($v);
            }
            return ajax('添加失败',-1);
        }
    }

    public function goodsModPost() {
        $val['name'] = input('post.name');
        $val['cate_id'] = input('post.cate_id');
        $val['status'] = input('post.status');
        $val['hot'] = input('post.hot');
        $val['number'] = input('post.number');
        $val['up_time'] = input('post.up_time');
        $val['is_new'] = input('post.is_new');
        $val['price'] = input('post.price');
        $val['stock'] = input('post.stock');
        $this->checkPost($val);
        $val['detail'] = input('post.detail');
        $val['id'] = input('post.id');

        $image = input('post.pic_url',[]);
        try {
            $exsit = Db::table('mp_goods')->where('id',$val['id'])->find();
            if(!$exsit) {
                return ajax('非法参数',-1);
            }
            $old_pics = unserialize($exsit['pics']);
            $image_array = [];
            if(is_array($image) && !empty($image)) {
                if(count($image) > 5) {
                    return ajax('最多上传5张图片',-1);
                }
                foreach ($image as $v) {
                    if(!file_exists($v)) {
                        return ajax('无效的图片路径',-1);
                    }
                }
                foreach ($image as $v) {
                    $image_array[] = $this->rename_file($v);
                }
            }else {
                return ajax('请上传图片',-1);
            }
            $val['pics'] = serialize($image_array);
            Db::table('mp_goods')->where('id',$val['id'])->update($val);
        }catch (\Exception $e) {
            foreach ($image_array as $v) {
                if(!in_array($v,$old_pics)) {
                    @unlink($v);
                }
            }
            return ajax($e->getMessage(),-1);
        }
        foreach ($old_pics as $v) {
            if(!in_array($v,$image_array)) {
                @unlink($v);
            }
        }
        return ajax();
    }

    public function recommend() {
        $id = input('post.id');
        try {
            $where = [
                ['id','=',$id]
            ];
            $exist = Db::table('mp_goods')->where($where)->find();
            if(!$exist) {
                return ajax('非法参数',-1);
            }
            if($exist['hot'] == 1) {
                Db::table('mp_goods')->where($where)->update(['hot'=>0]);
                return ajax(false);
            }else {
                Db::table('mp_goods')->where($where)->update(['hot'=>1]);
                return ajax(true);
            }
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
    }

    public function goodsHide() {
        $id = input('post.id', '0');
        $map = [
            ['id', '=', $id],
            ['status', '=', 1]
        ];
        try {
            Db::table('mp_goods')->where($map)->update(['status' => 0]);
        } catch (\Exception $e) {
            return ajax($e->getMessage(), -1);
        }
        return ajax();

    }

    public function goodsShow() {
        $id = input('post.id','0');
        $map = [
            ['id','=',$id],
            ['status','=',0]
        ];
        try {
            Db::table('mp_goods')->where($map)->update(['status'=>1]);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function goodsDel() {
        $id = input('post.id','0');
        $map = [
            ['id','=',$id]
        ];
        try {
            $exist = Db::table('mp_goods')->where($map)->find();
            if(!$exist) {
                return ajax('非法参数',-1);
            }
            Db::table('mp_goods')->where($map)->delete();
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        $old_pics = unserialize($exist['pics']);
        foreach ($old_pics as $v) {
            @unlink($v);
        }
        return ajax();
    }

    public function cateList() {
        $pid = input('param.pid',0);
        $where = [
            ['pid','=',$pid],
            ['del','=',0]
        ];
        try {
            $list = Db::table('mp_goods_cate')->where($where)->select();
            $pcate_name = Db::table('mp_goods_cate')->where('id',$pid)->value('cate_name');
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('pcate_name',$pcate_name);
        $this->assign('pid',$pid);
        $this->assign('list',$list);
        return $this->fetch();
    }

    public function cateAdd() {
        $pid = input('param.pid',0);
        try {
            $list = Db::table('mp_goods_cate')->where('pid',0)->select();
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('list',$list);
        $this->assign('pid',$pid);
        return $this->fetch();
    }

    public function cateAddPost() {
        $val['cate_name'] = input('post.cate_name');
        $val['pid'] = input('post.pid',0);
        $this->checkPost($val);

        if(isset($_FILES['file'])) {
            $info = $this->upload('file');
            if($info['error'] === 0) {
                $val['icon'] = $info['data'];
            }else {
                return ajax($info['msg'],-1);
            }
        }
        try {
            Db::table('mp_goods_cate')->insert($val);
        }catch (\Exception $e) {
            if(isset($val['icon'])) {
                @unlink($val['icon']);
            }
            return ajax($e->getMessage(),-1);
        }
        return ajax([]);
    }

    public function cateDetail() {
        $id = input('param.id');
        try {
            $info = Db::table('mp_goods_cate')->where('id',$id)->find();
            $list = Db::table('mp_goods_cate')->where('pid',0)->select();
        }catch (\Exception $e) {
            die($e->getMessage());
        }
        $this->assign('info',$info);
        $this->assign('list',$list);
        return $this->fetch();
    }

    public function cateModPost() {
        $val['cate_name'] = input('post.cate_name');
        $val['id'] = input('post.id',0);
        $this->checkPost($val);
        try {
            $exist = Db::table('mp_goods_cate')->where('id',$val['id'])->find();
            if(!$exist) {
                return ajax('非法参数',-1);
            }
            if(isset($_FILES['file'])) {
                $info = $this->upload('file');
                if($info['error'] === 0) {
                    $val['icon'] = $info['data'];
                }else {
                    return ajax($info['msg'],-1);
                }
            }
            Db::table('mp_goods_cate')->where('id',$val['id'])->update($val);
        }catch (\Exception $e) {
            if(isset($val['icon'])) {
                @unlink($val['icon']);
            }
            return ajax($e->getMessage(),-1);
        }
        if(isset($val['icon'])) {
            @unlink($exist['icon']);
        }
        return ajax([]);
    }

    public function cateHide() {
        $id = input('post.id');
        try {
            $exist = Db::table('mp_goods_cate')->where('id',$id)->find();
            if(!$exist) {
                return ajax('非法参数',-1);
            }
            Db::table('mp_goods_cate')->where('id',$id)->update(['status'=>0]);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function cateShow() {
        $id = input('post.id');
        try {
            $exist = Db::table('mp_goods_cate')->where('id',$id)->find();
            if(!$exist) {
                return ajax('非法参数',-1);
            }
            Db::table('mp_goods_cate')->where('id',$id)->update(['status'=>1]);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }

    public function cateDel() {
        $id = input('post.id');
        try {
            $exist = Db::table('mp_goods_cate')->where('id',$id)->find();
            if(!$exist) {
                return ajax('非法参数',-1);
            }
            Db::table('mp_goods_cate')->where('id',$id)->update(['del'=>1]);
        }catch (\Exception $e) {
            return ajax($e->getMessage(),-1);
        }
        return ajax();
    }





}