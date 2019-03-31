<?php
namespace app\admin\controller;
use my\Auth;
use think\Db;
use think\Exception;
use EasyWeChat\Factory;

class Index extends Common
{
    //首页
    public function index() {
        $auth = new Auth();
        $authlist = $auth->getAuthList(session('admin_id'));
        $this->assign('authlist',$authlist);
        return $this->fetch();
    }


    //上传图片限制512KB
    public function uploadImage() {
        if(!empty($_FILES)) {
            $path = $this->uploadTmp(array_keys($_FILES)[0]);
            return ajax(['path'=>$path]);
        }else {
            return ajax('请上传图片',-1);
        }
    }


}
