````
<?php
function adminer_object() {
  class AdminerSoftware extends Adminer {
		function credentials() {
			# You don't need this if statement, but I added it because not having 
			# it skipped the login screen for everyone.
			if ($_GET['username'] == 'lianghong'){
                return array("127.0.0.1:3306", "root", "root");
			}
		}
	}
	return new AdminerSoftware;
}
include "./adminer-4.2.5.php";
````
