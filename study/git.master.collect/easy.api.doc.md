## api.doc
```php
$wait=array('待更新'=> array('待更新','待更新','','',array(),),);
$apis = array(
    'nonce' => array(
        'title' => '安全验证',
        'des' => '通过控制器和方法名获取令牌，令牌12小时会自动更新，24小时有效<br />
            获取格式：/api/?controller=控制器&method=方法名',
        'content' => array(
            '令牌 √3.11' => array(
                '获取与验证' => array(
                    '/api/get_nonce/?controller=&method=login',
                    '{"status":"ok","controller":"","method":"login","nonce":"0bf680a229"}',
                    '当提示nonce参数时，或提示nonce参数错误时，请重新获取该参数<br />其它方法的使用/api/控制器/方法名/?cookie=cookie值',
                    '24小时内<strong>登录</strong>操作的令牌<a href="/api/?controller=&method=login" target="_blank">点这里测试</a>',
                    array (
                        '输入参数'=>array(
                          array ('字段名' => 'controller','格式' => '字符串','意义' => '控制器','备注' => '',),
                          array ('字段名' => 'method','格式' => '字符串','意义' => '方法名','备注' => '',),
                        ),
                        '输出参数'=>array(
                          array ('字段名' => 'status','格式' => '字符串','意义' => '访问状态','备注' => '',),
                          array ('字段名' => 'controller','格式' => '字符串','意义' => '控制器','备注' => '',),
                          array ('字段名' => 'method','格式' => '字符串','意义' => '方法名','备注' => '',),
                        ),
                   ),
                ) ,
            ) ,
            '通用令牌 √3.10' => array(
                '获取与验证' => array(
                    '/api/get_nonce/?controller=&method=fastnonce',
                    '{"status":"ok","controller":"","method":"fastnonce","nonce":"3bbcb111a8"}',
                    '<b>本方法是考虑到第一版时间紧急，获取令牌后，可使用该令牌直接进行其它任何操作。该方法存在安全隐患，第二版或将取消。</b>',
                    '24小时内<strong>所有</strong>操作的令牌<a href="/api/?controller=&method=fastnonce" target="_blank">点这里测试</a>',
                ) ,
            ) ,
        ) ,
    ) , 
);


















function arr2table($data,$level=1,$opera=array()) {
	if(!isset($data[0])){$data=array($data);}
    $str='';//$level==1?'这里原先是样式表':'';$level++;
	$str.='<table class="line" border="0" cellpadding="0"><tr>';
	$fields=array_keys($data[0]);
	foreach($fields as $val) {$str.='<th>'.$val.'</th>';}
	if (2==$level && !empty($opera) && !empty($data[0])) {$str.='<th>操作</th>';}
	$str.='</tr>';
	foreach($data as $v) {
		$str.='<tr>';
		foreach($fields as $val) {
			if(is_array($v[$val])) {
				$str.= empty($v[$val])?'<td></td>':'<td> '.arr2table($v[$val],$level).' </td>';
			} else {
				$str.=empty($v[$val])?'<td></td>':'<td>'.htmlspecialchars($v[$val]).'</td>';
			}
		}
		//增加一个操作列
		if (2==$level && !empty($opera) && !empty($data[0])) {
			$str.='<td>';
			foreach ($opera as $opera_link => $opera_url) {
				$pk=isset($opera_url['pk'])?$opera_url['pk']:'id';
				$str.=' <a href="'.$opera_url['url'].$v[$pk].'" ';
				unset($opera_url['url']);
				foreach ($opera_url as $key => $val) {
					$str.=$key.'="'.$val.'"';
				}
				$str.='>'.$opera_link.'</a>';
			}
			$str.='</td>';
		}
		$str.='</tr>';
	}
	$str.='</table>';
	return $str;
}
?>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf8" /><title>API</title></head>
<body>
<div id="demo2" class="demo"><span>API目录</span>
    <ol class="mulu">
<?php
foreach($apis as $method=>$m){
	echo '<li><a class="ca" href="#'.$method.'"> '.$m['title'].' </a>';
    $tmp='<ol>';//var_dump($m['content']);
    foreach($m['content'] as $t => $c){$tmp.='<li class="f"><a class="ca" href="#'.$t.'"> '.$t.'</a></li>';}
        $tmp.='</ol>';
        echo $tmp;
    echo '</li>';
}

//  .f{float:left;padding-left:3px;display: inline;}
?></ol>
</div>
<style>
*{font-family:arial,Helvetica,sans-serif;}
    BODY {margin:0;padding:0;border:0;}
    ol {font-size:12px;}
    .mulu {padding:0;margin:0;padding-left:20px;display:block;}
    ol ol { list-style-type: upper-alpha }
    ol ol ol{ list-style-type: lower-alpha }
    red{color:red;}b,h1{color:#003366;}h2{color:blue}
    .demo{width:180px; margin:10px;border:2px solid #003366;color:#fff; background:#003366; padding:10px;}
    #demo2{position:absolute; margin-top:66px;  right:30px;}
    .demo a{text-decoration:underline; cursor:pointer;color:#fff; }
    .demo p{line-height:20px}
    
    .line{width:100%;font-size:12px;} 
    .line td{border-style:solid; border-color:#003366; border-width:1px;text-align:center} 
    .line th{background-color:#003366;color:#fff}
</style>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.4.2/jquery.min.js"></script>

<script type="text/javascript" src="jquery.cookie.js"></script>
<script type="text/javascript" src="jquery.scroll-follow.js"></script>
<script type="text/javascript">$(function(){$("#demo2").scrollFollow({speed:800,});});</script>
    <div style="background-color: #003366;color: #FFFFFF;font-size: 26px;width: 100%;">
        <div style="padding:3 40 0 60px;">官方API接口<font size='1'>更新：<?php echo date('Y-m-d H:i:s',filemtime (__FILE__));?></font></div>
        <div style="padding:1 40 5 60px;;"><font size='1'>特别说明：本接口全部使用主流json格式进行数据传输，并提供友好错误提示。加上dev=1参数会显示友好格式。——clh021@gmail.com <a href="/_sql.php" target="_blank" style="color:yellow">数据库结构</a></font></div>
    </div>
<div style="font-size:12px;padding-left: 30px;padding-bottom: 2em;">
	<span>
		<ol><?php
foreach($apis as $method=>$m){
    echo '<li><h1 id="'.$method.'">'.$m['title'].'</h1>';
    echo $m['des']?'<span>说明：'.$m['des'].'</span>':'';
    echo '<ol>';
    //var_dump($m['content']);
    foreach($m['content'] as $tittle=>$func){
        echo '';
            echo '<li><h2 id="'.$tittle.'">'.$tittle.'</h2><ol>';
        	if(count($func)>1){
            	foreach($func as $k=>$v){
                    echo '<li><h3>'.$k.'</h3><p><b>请求:</b>'.$v[0].'</p><fieldset style="width:78%;"><legend>返回</legend>'.$v[1].'</fieldset>';
                	echo !empty($v[2])?'<p>'.$v[2].'</p>':'';
                    echo !empty($v[3])?'<fieldset style="width:78%;"><legend>测试</legend>'.$v[3].'</fieldset>':'';
                    if(!empty($v[4])){
                        foreach($v[4] as $title=>$table){
                            if($table){echo '<fieldset style="width:78%;"><legend>'.$title.'</legend>'.arr2table($table).'</fieldset>';}
                        }
                    }
                	echo '</li>';
                }
            }else{
            	foreach($func as $k=>$v){
                    echo '<p><b>请求:</b>'.$v[0].'</p><fieldset style="width:78%;"><legend>返回</legend>'.$v[1].'</fieldset>';
                    echo !empty($v[2])?'<p>'.$v[2].'</p>':'';
                    echo !empty($v[3])?'<fieldset style="width:78%;"><legend>测试</legend>'.$v[3].'</fieldset>':'';
                    if(!empty($v[4])){
                        foreach($v[4] as $title=>$table){
                            if($table){echo '<fieldset style="width:78%;"><legend>'.$title.'</legend>'.arr2table($table).'</fieldset>';}
                        }
                    }
                }
            }
        echo '</ol></li>';
    }
    echo '</ol></li>';
}
?></ol>
    </span>
</div>
<script type="text/javascript" src="jquery.cookie.js"></script>
<script type="text/javascript" src="jquery.scroll-follow.js"></script>
</body>
</html>
<?php
```





## mysql.doc
```
echo '<head><meta http-equiv="Content-Type" content="text/html; charset=utf8" /><meta name="author" content="clh021@gmail.com"><title>数据库</title></head><style>*{font-family:arial,Helvetica,sans-serif;}BODY {margin:0;padding:0;border:0;font-size:12px;}div{margin-top:5px;margin:10px;padding:10px;border: 1px solid 666666; }</style>';
$sqlfile=dirname(__FILE__).'/wp-sql.php';
if($_REQUEST['dev']==1){
    echo highlight_string(file_get_contents($sqlfile));
} else {
    echo '<h1 style="text-align:center;">数据库<font size=1>更新：'.date('m-d H:i:s',filemtime ($sqlfile)).'</font></h1>';
    $data=include($sqlfile);//array();//
    foreach($data as $k=>$v){
        //if(rand(0,1)){
        if(! stristr($k,'modify_')){
            echo '<div><font color="blue"><b>'.$k.'</b></font><hr /><pre>'.str_replace('__PREFIX__','',$v).'</pre></div>';
        }
    }
}
```
