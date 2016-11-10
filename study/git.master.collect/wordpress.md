### 从头开始做wordpress
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
