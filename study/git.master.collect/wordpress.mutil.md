```php
改造 wordpress 为多人使用，自动根据域名切换数据库来实现
根据二级域名切换表前缀来实现的
============================= code begin ============================================

/*----------此处实现一博多用，一博共享-------begin-------*/
//$_SESSION['CURRENT_TABLE_PREFIX']='lianghong_';
if($_SESSION['CURRENT_TABLE_PREFIX']) {
define('CURRENT_TABLE_PREFIX',$_SESSION['CURRENT_TABLE_PREFIX']);
}

if(!defined('CURRENT_TABLE_PREFIX')) {
//考虑到可能会有独立域名绑定到本应用特优化程序
$leehom_no_problem=false;
//常规的允许访问的二级域名（除此处外无需其它配置）
$allow_dongshenghuo=array(
'lianghong.sinaapp.com',
'lianghong.dongshenghuo.com',
'pingli.dongshenghuo.com',
'yaqin.dongshenghuo.com',
);

if(in_array($_SERVER['SERVER_NAME'],$allow_dongshenghuo)) {
    define('CURRENT_TABLE_PREFIX',strstr($_SERVER['SERVER_NAME'],'.',true).'_');
} else {
    include('dongshenghuo.php');die();
}

/*----------此处实现各博客访问统计-------begin-------*/
//if(true === $leehom_no_problem) {
    $counter_name = date('YmdH') . $_SERVER['SERVER_NAME'];//substr(CURRENT_TABLE_PREFIX,0,-1);
    $c = new Counter;//自己构建
    if($c->exists($counter_name)) {
        $c->incr($counter_name);
    } else {
        $c->create($counter_name,1);
    }
//}
/*----------此处实现各博客访问统计--------end--------*/
/*
//允许自定义的其它域名
if(!defined('CURRENT_TABLE_PREFIX')) {
    $allow_others=array(
        //前缀 => array(允许的域名集合),
        //'lianghong' => array('lianghong.sinaapp.com','lianghong.dongshenghuo.com'),
    );
    foreach($allow_others as $key => $val) {
        if(in_array($_SERVER['SERVER_NAME'],$val)) { define('CURRENT_TABLE_PREFIX',$key.'_'); break; }
    }
}*/
}
/*----------此处实现一博多用，一博共享--------end--------*/

//兼容本地
if ( !defined('SAE_MYSQL_DB') ) {
    define('SAE_MYSQL_DB', 'lianghong');
    define('SAE_MYSQL_USER', 'root');
    define('SAE_MYSQL_PASS', 'root');
    define('SAE_MYSQL_HOST_M', 'localhost');
    define('SAE_MYSQL_HOST_S', 'localhost');
    define('SAE_MYSQL_PORT', '3306');
    define('SAE_ACCESSKEY', '');
    define('SAE_SECRETKEY', '');
}


============================================= code end ==========================================




数据库表配置
define('DB_NAME', SAE_MYSQL_DB);
define('DB_USER', SAE_MYSQL_USER);
define('DB_PASSWORD', SAE_MYSQL_PASS);
define('DB_HOST', SAE_MYSQL_HOST_M.':'.SAE_MYSQL_PORT);
数据库表前缀配置
$table_prefix  = CURRENT_TABLE_PREFIX ;//strstr($_SERVER['SERVER_NAME'],'.',true).'_'; //'wp_';
```
