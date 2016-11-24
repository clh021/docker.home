var casper = require("casper").create();
casper.start('http://id.cazool.org/login', function() {
    this.test.assertTitle('登录 - 深度用户中心', 'title is found');
    this.test.assertExists('form[action="/login_check"]', 'main form is found');
    this.fill('form[action="/login_check"]', {
        'deepinid_userbundle_user[email]': 'clh21@126.com',
        'deepinid_userbundle_user[password]': '123456'
    }, true);//参数true,表示填充完毕后,立刻提交表单
});

casper.then(function() {
    this.test.assertTextExists('登录成功','login success')
});

casper.run(function() {
    this.test.renderResults(true);
    this.exit();
});
