# WordPress集合
## 从头开始做wordpress
部署、更新、脏检查
```
git clone --depth=1 https://github.com/WordPress/WordPress.git wordpress
```
PHP环境
```
sudo apt install php7.0 #deepin or install php5
sudo apt install php7.0-fileinfo php7.0-curl php7.0-gd php7.0-imap php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-odbc php7.0-pgsql php7.0-sqlite3 php7.0-xml php7.0-xmlrpc php7.0-zip#PHP扩展
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

开发扩展

    `Advanced Custom Fields`繁简适宜、方便快捷的自定义字段管理
    `Page Builder`简单快速拖拽创建页面

后台界面

    `ag-custom-admin`管理后台界面个性化定制
    `Admin Menu Editor`管理后台界面可见性工具，有可视化视图
    `TinyMCE Advanced`编辑器更强大好看，支持ajax保存
  
功能扩展

    `bbPress`论坛功能
    `WooCommcerce`在线商店，稳定，可靠，功能强大
    `Code Snippets`可以添加代码片段以避免修改function.php,有良好的编码配色界面
    `Contact Form 7`你可以自定义读者联系你的表单，表单直接发送邮件给你
    `Wordfence Security`安全防护
    `WordPress Database Backup`保存包含插件表的数据库
    `W3 Total Cache`浏览器缓存、页面缓存、对象缓存、数据库缓存、页面压缩
    `WP Super Cache`浏览器缓存、生成 HTML 副本
    `iThemes Security`保护网站安全
    `Clef Two-Factor Authentication`双重认证,通过手机同步来提供更快、更受保护的登录方式
    `Regenerate Thumbnails`生成不同尺寸的图片缩略图
    `Akismet`反垃圾评论
    `WP Statistics`全面且实用的访问统计
