# WordPress集合
## 从头开始做wordpress
部署、更新、脏检查
```
git clone --depth=1 https://github.com/WordPress/WordPress.git wordpress
```
PHP环境
```
# deepin php7
sudo apt install php7.0
sudo apt install php7.0-fileinfo php7.0-curl php7.0-gd php7.0-imap php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-odbc php7.0-pgsql php7.0-sqlite3 php7.0-xml php7.0-xmlrpc php7.0-zip#PHP扩展

# debian php5
apt install php5
apt install php-file php5-curl php5-gd php5-imap php5-imagick php5-intl php5-json php5-mcrypt php5-mysql php5-pgsql php5-sqlite php5-ssh2 php5-xmlrpc
```
服务器配置(非必须)
```
<VirtualHost *:80>
	#ServerName www.example.com #域名，ip访问可不配置
	ServerAdmin webmaster@localhost #你的邮箱，错误页面可联系到你
	DocumentRoot /var/www/html
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
	<Directory "/var/www/html"> #添加用户认证
        AuthType Basic
        AuthName "Restricted Content"
        AuthUserFile /etc/apache2/.htpasswd
        #sudo htpasswd -c /etc/apache2/.htpasswd username #设置验证文件，或增加用户，[你也可以改变文件目录]
        Require valid-user
    </Directory>
    <Directory /var/www/> #允许启用.htaccess #注意开启 mod_rewrite #sudo a2enmod rewrite
	    Options Indexes FollowSymLinks
	    AllowOverride All
	    Require all granted
	</Directory>
</VirtualHost>
```
验证好数据库配置，并按照提示手动创建wp-config.php文件，于最终安装好wordpress。
安装好后，手动修改wordpress的wp-config.php配置文件
```
//设置本地语言为中文
define('WPLANG', 'zh_CN');
//设置本地文件读写模式，不使用ftp方式安装插件和主题 
//你也可以在安装好各种插件和主题以后删除下面的配置来保证安全，当然同时也无法方便的自动升级了。
define("FS_METHOD","direct");
define("FS_CHMOD_DIR", 0777);
define("FS_CHMOD_FILE", 0777);
//同时配置本地写命令 `sudo chmod 777 -R wp-content`，撤销命令为`sudo chmod 755 -R wp-content`
```
登录到后台，在更新按钮中点击 `Update Translations` 按钮，获取本地化。
获取本地化完成后，可更新各个主题插件的翻译。

## 技巧 × 精品插件 × 人见人爱

### 开发扩展
- `Developer`官方出品的开发者开发插件，开发调试几乎别无所求，这是一个插件组
- `cformsII - contact form`灵活强大可定制ajax表单
- `Advanced Custom Fields`让站长繁简适宜、方便快捷的自定义字段
- `Developer's Custom Fields`让开发者轻松灵活的定义字段
- `Page Builder`简单快速拖拽创建页面
- `Baidu Maps Plugin`百度地图
- `Google Map`谷歌地图 由SRMILON创建
- `Theme Test Drive`安全的指定用户在线测试开发主题
- `Plugin Test Drive`在不启用插件的情况下测试开发插件
- `Debug Bar`一个调试面板可进行多种调试功能
- `Log Deprecated Notices`不需要WP_DEBUG的情况下看日志
- `Monster Widget`十三个核心部件的集合，方便快速的开发主题
- `Regenerate Thumbnails`生成不同尺寸的图片缩略图，在切换或开发主题时非常方便
- `Simply Show IDs`无处不在的ID也许能给你带来方便
- `Query Monitor`记录所有请求并统计详情供分析
- `WordPress REST API (Version 2)`易于使用和理解的REST API，还包括基于Backbone模型的JavaScript API，允许插件和主题开发者使用
- `Hide My Wordpress`隐藏wordpress常规特征，可用于伪装，更可用于保护站点安全
    

### 后台界面
- `ag-custom-admin`管理后台界面个性化定制
- `Admin Menu Editor`管理后台界面可见性工具，有可视化视图
- `TinyMCE Advanced`编辑器更强大好看，支持ajax保存
  
### 功能扩展
- `bbPress`论坛功能
- `WooCommcerce`在线商店，稳定，可靠，功能强大
- `Code Snippets`可以添加代码片段以避免修改function.php,有良好的编码配色界面
- `Contact Form 7`你可以自定义读者联系你的表单，表单直接发送邮件给你
- `Wordfence Security`安全防护
- `WordPress Database Backup`保存包含插件表的数据库
- `W3 Total Cache`浏览器缓存、页面缓存、对象缓存、数据库缓存、页面压缩
- `WP Super Cache`浏览器缓存、生成 HTML 副本
- `iThemes Security`保护网站安全
- `Clef Two-Factor Authentication`双重认证,通过手机同步来提供更快、更受保护的登录方式
- `Akismet`反垃圾评论
- `WP Statistics`全面且实用的访问统计
- `NextGEN Gallery`功能强大的相册幻灯片类
- `Jetpack`需要链接wordpress的系列强大功能服务

### 服务器技巧

```
#快速禁用某网站
sudo a2dissite <my-site>
#服务命令
sudo service apache2 reload
sudo service apache2 restart
#测试配置
apache2ctl configtest
#快速查看和修改.htaccess
sudo nano /var/www/html/.htaccess
#调试.htaccess
RewriteLog logs/drupal001.com-rewrite.log #此处可以写绝对地址
RewriteLogLevel 3
#非正规调试.htaccess 可方便查看各种变量并轻松检查RewriteCond是否正确
RewriteCond %{QUERY_STRING} vardump #http://url/?vardump
RewriteRule (.*) http://www.baidu.com/?host=%{HTTP_HOST},rurl=%{REQUEST_URI} [R=301,L,QSA]
#apache默认变量列表
#HTTP_USER_AGENT HTTP_REFERER HTTP_COOKIE HTTP_FORWARDED HTTP_HOST HTTP_PROXY_CONNECTION HTTP_ACCEPT   REMOTE_ADDR REMOTE_HOST REMOTE_PORT REMOTE_USER REMOTE_IDENT REQUEST_METHOD SCRIPT_FILENAME PATH_INFO QUERY_STRING AUTH_TYPE   DOCUMENT_ROOT SERVER_ADMIN SERVER_NAME SERVER_ADDR SERVER_PORT SERVER_PROTOCOL SERVER_SOFTWARE   TIME_YEAR TIME_MON TIME_DAY TIME_HOUR TIME_MIN TIME_SEC TIME_WDAY TIME   API_VERSION THE_REQUEST REQUEST_URI REQUEST_FILENAME IS_SUBREQ HTTPS
```

### 开发者资料
- [themehybrid](http://themehybrid.com/themes/hybrid-child) 全息开发框架，二次开发主题，主题继承，貌似也支持插件开发
- [plaintxt](http://www.plaintxt.org/) 各种排版的空白主题，可快速定制自己想要的[主题](https://wordpress.org/themes/sandbox/)
- [官方主题手册之模板层次](https://developer.wordpress.org/themes/basics/template-hierarchy/) 详细讲解页面继承关系和提供的钩子
- [官方插件手册](https://developer.wordpress.org/plugins/) 
- [官方代码函数库](https://codex.wordpress.org/)
- [主题选项框架](https://wordpress.org/plugins/options-framework/)
- [generatewp](https://generatewp.com) 代码生成工具
- [underscores](http://underscores.me/) 功能全面，理解简单的主题，非常适合二次开发
- [foundation](http://foundation.zurb.com/) 响应式网页设计,除了bootstrap还可以考虑它
- [theme-check](https://wordpress.org/plugins/theme-check/) 开发主题时常检查是个好习惯
- [官方Theme_Unit_Test](https://codex.wordpress.org/Theme_Unit_Test) 测试数据，让主题更完美
- [html5blank](http://html5blank.com/) 最值得二次开发的空白主题
- [jiustore](https://www.jiustore.com/) 6.5小时主题视频教程变成主题制作高手同时会子主题开发 [jiufree](https://www.jiufree.com/) [jiuwp](http://www.jiuwp.com/)
- [设计窝](http://www.shejiwo.net/) 主题定制服务

> 使用人数众多的大都是值得一试的好东西，它可以大量节省你的时间精力；但是更好更适合你的东西却不一定使用人数众多，因为有痛点才会有更好的产品，新出来的产品正在等待验证。人应该无时无刻注意到节省自己的时间精力，提高效率，提高产出。借势而为，借力使力，站在巨人的肩膀上向前走，人类才一步步实现了今天科技的进步。
> 如果能够有人指点你，有人帮助你，有人和你网一个方向使力，一定可以比你自己一个人投入时间，精力，慢慢摸索来的好。你可以有更多的时间精力去做更加有生产力，更加有意义的事情当中。
