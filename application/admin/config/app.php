<?php
/**
 * Created by PhpStorm.
 * User: JHR
 * Date: 2018/9/25
 * Time: 13:57
 */

return array(
    'layout_on'     =>  true,
    'layout_name'   =>  'layout',
    'page'   =>  1,
    'perpage'   =>  5,
    'login_key' => 'jiang',
    'app_trace' => true,

    'trace'     =>  [
        //支持Html,Console
        'type'  =>  'html',
    ],
    'superman'  => 'show',
    'auth'  => [
        'auth_on' => true,
        'auth_type'         => 1, // 认证方式，1为实时认证；2为登录认证。
        'auth_out'          => [
            'Index/index'
        ]
    ],
    // 默认控制器名
    'default_controller'     => 'Login',
    // 默认操作名
    'default_action'         => 'index',
);