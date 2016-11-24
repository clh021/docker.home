# These lists can help you to find test which you want

# To prepare for later tests
# To test the registration page
# To test the registration using the new password with wrong length
# To test the registration function
# To test the registration using the email has been registered

# To test the login page
# To test login with incorrect password
# To test login with incorrect email
# To test login of the account not activated

# To test resending the activating email
# To test the false activating link
# To test the function of activating account

# To test the normal login operation

# To test the normal logout operation
# To test the page which you must login to visit after logout

# To test the page of finding password
# To test the function of finding password by sending email
# To test the false link of resetting password
# To test the normal function of resetting password
# To test the normal login operation with new password








# Test Account Config
testAccount =
  email : 'clh21@126.com'
  password : '123456'

testTranslator =
  register : '注册'
  deepin_user_center : '深度用户中心'
  hasaccount2login : '已有账号，直接登录'
  password_wrong_length : '长度不可少于'
  register_ok : '注册成功'
  login : '登录'
  open_activation_link_to_login : '打开邮件中的激活链接即可登录系统'
  exists_has_been_regedited : '邮箱已经存在。您可以直接登录或者通过邮箱找回账号。'
  invalid_username_or_password : '账号或密码错误'
  account_not_activated : '账号没有激活'
  account_not_activated_explain : '打开邮件中的激活链接'
  login_ok : '登录成功'
  activate_explain : '输入您的邮箱以重新发送激活邮件到您的邮箱中。激活验证仅一次有效。'
  send_success : '发送成功'
  activation_link_expired : '激活链接过期'
  activate_wrong : '激活失败'
  obtain_activation_email_again : '重新获取激活邮件'
  activate_ok: '激活成功'
  go_login: '快去登录吧！'
  save_logout_success: '安全注销成功'
  should_login_first: '您还没有登录，请先登录'
  find_password : '找回密码'
  find_password_explain : '输入注册邮箱，我们将发送重置密码的链接到您的邮箱中，链接1小时内有效。'
  password_reset_mail_send_success: '重置密码邮件发送成功'
  email_access_authorization_link: '请访问邮件中的授权链接'
  set_new_password: '请为您的账号设置新密码'
  authorized_link_error: '授权链接错误'
  authorized_link_error_explain_reset_password: '您重置密码的授权链接有问题，请您检查链接或者重新发送邮件。'
  resetpassword_ok_go_login: '密码修改成功快去登录吧！'

testUrl =
  domain : 'http://id.cazool.org'
  register : '/register'
  login : '/login'
  logout : '/logoff'
  activate_register : '/activate_register' #To resend the activation email
  findpassword : '/findpassword'
  resetpassword : '/resetpassword'
  serverHelp :
    delAccount : '/jstest/del/account/' # + email
    get_activation_check : '/jstest/get/activation/check/' # + email
    get_reset_password_check : '/jstest/get/reset_password/check/' # + email




# To prepare for later tests
# To test the registration page
# To test the registration using the new password with wrong length
# To test the registration function
# To test the registration using the email has been registered

casper.test.begin 'To prepare for later tests', 1, suite = (test) ->
  casper.start().then ->
    @open testUrl.domain + testUrl.serverHelp.delAccount + testAccount.email,
      method: "get"
      headers:
        Accept: "application/json"
    return
  casper.run ->
    serverResult = eval ("(" + @getPageContent() + ")")
    test.assert serverResult.success, 'Delete test account "' + testAccount.email + '" OK.'
    test.done()
    return
  return

casper.test.begin 'To test the registration page', 3, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.register,
    headers:
      'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6'
  casper.then ->
    test.assertTitle testTranslator.register + ' - ' + testTranslator.deepin_user_center, 'Found title ' + testTranslator.register + ' - ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.hasaccount2login, 'Found link ' + testTranslator.hasaccount2login
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found form'
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test the registration using the new password with wrong length', 2, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.register
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_user"]',
      'deepinid_userbundle_user[email]': testAccount.email
      'deepinid_userbundle_user[password]': '12345'
    , true
    return
  casper.then ->
    @wait 1000, ->
      test.assertTextExists testTranslator.password_wrong_length, 'Find message ' + testTranslator.password_wrong_length
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test the registration function', 3, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.register
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_user"]',
      'deepinid_userbundle_user[email]': testAccount.email
      'deepinid_userbundle_user[password]': testAccount.password
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.register_ok, 'Register Ok ' + testTranslator.register_ok
    test.assertTextExists testTranslator.open_activation_link_to_login, 'Register SUCCESS ' + testTranslator.open_activation_link_to_login
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test the registration using the email has been registered', 2, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.register
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_user"]',
      'deepinid_userbundle_user[email]': testAccount.email
      'deepinid_userbundle_user[password]': testAccount.password
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.exists_has_been_regedited, 'Find message ' + testTranslator.exists_has_been_regedited
    return
  casper.run ->
    test.done()
    return
  return




# To test the login page
# To test login with incorrect password
# To test login with incorrect email
# To test login of the account not activated

casper.test.begin 'To test the login page', 3, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.login
  casper.then ->
    test.assertTitle testTranslator.login + ' - ' + testTranslator.deepin_user_center, 'Found title ' + testTranslator.login + ' - ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.deepin_user_center, 'Found text ' + testTranslator.deepin_user_center
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found form'
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test login with incorrect password', 2, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.login
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_user"]',
      'deepinid_userbundle_user[email]': testAccount.email
      'deepinid_userbundle_user[password]': '1234gfdsh'#testAccount.password
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.invalid_username_or_password, 'Find message ' + testTranslator.invalid_username_or_password
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test login with incorrect email', 2, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.login
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found Form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_user"]',
      'deepinid_userbundle_user[email]': 'clh213'#testAccount.email
      'deepinid_userbundle_user[password]': testAccount.password
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.invalid_username_or_password, 'Find message ' + testTranslator.invalid_username_or_password
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test login of the account not activated', 4, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.login
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found Form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_user"]',
      'deepinid_userbundle_user[email]': testAccount.email
      'deepinid_userbundle_user[password]': testAccount.password
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.account_not_activated, 'Find message ' + testTranslator.account_not_activated
    test.assertTextExists testTranslator.account_not_activated_explain, 'Find message ' + testTranslator.account_not_activated_explain
    @wait 3000, -> # auto jump activating url
      test.assertTextExists testTranslator.activate_explain, 'Find message ' + testTranslator.activate_explain
    return
  casper.run ->
    test.done()
    return
  return




# To test resending the activating email
# To test the false activating link
# To test the function of activating account

casper.test.begin 'To test resending the activating email', 3, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.activate_register
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_send_email"]', 'Found Form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_send_email"]',
      'deepinid_userbundle_send_email[email]': testAccount.email
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.send_success, 'Find message ' + testTranslator.send_success
    test.assertTextExists testTranslator.open_activation_link_to_login, 'Find message ' + testTranslator.open_activation_link_to_login
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test the false activating link', 2, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.activate_register + '/email/' + testAccount.email + '/check/' + '123456789'
  casper.then ->
    @echo testUrl.domain + testUrl.activate_register + '/email/' + testAccount.email + '/check/' + '123456789'
    test.assertTextExists testTranslator.activate_wrong, 'Find message ' + testTranslator.activate_wrong
    test.assertTextExists testTranslator.obtain_activation_email_again, 'Find message ' + testTranslator.obtain_activation_email_again
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test the function of activating account', 3, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.serverHelp.get_activation_check + testAccount.email
  casper.then ->
    serverResult = eval ("(" + @getPageContent() + ")")
    test.assert serverResult.success, serverResult.msg
    @echo testUrl.domain + testUrl.activate_register + '/email/' + testAccount.email + '/check/' + serverResult.msg
    @open testUrl.domain + testUrl.activate_register + '/email/' + testAccount.email + '/check/' + serverResult.msg
  casper.then ->
    test.assertTextExists testTranslator.activate_ok, 'Find message ' + testTranslator.activate_ok
    test.assertTextExists testTranslator.go_login, 'Find message ' + testTranslator.go_login
    return
  casper.run ->
    test.done()
    return
  return



# To test the normal login operation

casper.test.begin "To test the normal login operation", 4, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.login,
    headers:
      "Accept-Language": "zh-CN,zh;q=0.8,en;q=0.6"
  casper.then ->
    test.assertTitle testTranslator.login + ' - ' + testTranslator.deepin_user_center, 'Found title ' + testTranslator.login + ' - ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.deepin_user_center, 'Found text ' + testTranslator.deepin_user_center
    test.assertExists "form[action=\"/login_check\"]", "Found Form"
    @fill "form[action=\"/login_check\"]",
      'deepinid_userbundle_user[email]': testAccount.email
      'deepinid_userbundle_user[password]': testAccount.password
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.login_ok, "Login SUCCESS " + testTranslator.login_ok
    return
  casper.run ->
    test.done()
    return
  return






# To test the normal logout operation
# To test the page which you must login to visit after logout

casper.test.begin "To test the normal logout operation", 2, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.logout,
    headers:
      "Accept-Language": "zh-CN,zh;q=0.8,en;q=0.6"
  casper.then ->
    test.assertTextExists testTranslator.deepin_user_center, 'Found text ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.save_logout_success, 'Found text ' + testTranslator.save_logout_success
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin "To test the page which you must login to visit after logout", 2, suite = (test) ->
  casper.start()
  casper.open testUrl.domain,
    headers:
      "Accept-Language": "zh-CN,zh;q=0.8,en;q=0.6"
  casper.then ->
    test.assertTextExists testTranslator.deepin_user_center, 'Found text ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.should_login_first, 'Found text ' + testTranslator.should_login_first
    return
  casper.run ->
    test.done()
    return
  return



# To test the page of finding password
# To test the function of finding password by sending email
# To test the false link of resetting password
# To test the normal function of resetting password
# To test the normal login operation with new password

casper.test.begin "To test the page of finding password", 4, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.findpassword,
    headers:
      "Accept-Language": "zh-CN,zh;q=0.8,en;q=0.6"
  casper.then ->
    test.assertTitle testTranslator.find_password + ' - ' + testTranslator.deepin_user_center, 'Found title ' + testTranslator.find_password + ' - ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.find_password, 'Found text ' + testTranslator.find_password
    test.assertTextExists testTranslator.find_password_explain, 'Found text ' + testTranslator.find_password_explain
    test.assertExists 'form[name="deepinid_userbundle_send_email"]', 'Found form'
    return
  casper.run ->
    test.done()
    return
  return

  casper.test.begin "To test the function of finding password by sending email", 4, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.findpassword,
    headers:
      "Accept-Language": "zh-CN,zh;q=0.8,en;q=0.6"
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_send_email"]', 'Found form'
    return
  casper.then ->
    @fill 'form[name="deepinid_userbundle_send_email"]',
      'deepinid_userbundle_send_email[email]': testAccount.email
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.deepin_user_center, 'Find message ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.password_reset_mail_send_success, 'Find message ' + testTranslator.password_reset_mail_send_success
    test.assertTextExists testTranslator.email_access_authorization_link, 'Find message ' + testTranslator.email_access_authorization_link
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin "To test the false link of resetting password", 3, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.serverHelp.get_reset_password_check + testAccount.email
  casper.then ->
    @open testUrl.domain + testUrl.resetpassword + '/email/' + testAccount.email + '/t/123456789/check/123456789'
    return
  casper.then ->
    test.assertTextExists testTranslator.deepin_user_center, 'Find message ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.authorized_link_error, 'Find message ' + testTranslator.authorized_link_error
    test.assertTextExists testTranslator.authorized_link_error_explain_reset_password, 'Find message ' + testTranslator.authorized_link_error_explain_reset_password
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin "To test the normal function of resetting password", 5, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.serverHelp.get_reset_password_check + testAccount.email
  casper.then ->
    serverResult = eval ("(" + @getPageContent() + ")")
    test.assert serverResult.success, serverResult.msg.check
    @echo testUrl.domain + testUrl.resetpassword + '/email/' + testAccount.email + '/t/' + serverResult.msg.t + '/check/' + serverResult.msg.check
    @open testUrl.domain + testUrl.resetpassword + '/email/' + testAccount.email + '/t/' + serverResult.msg.t + '/check/' + serverResult.msg.check
    return
  casper.then ->
    test.assertTextExists testTranslator.deepin_user_center, 'Find message ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.set_new_password, 'Find message ' + testTranslator.set_new_password
    test.assertExists 'form[name="deepinid_userbundle_reset_passowrd"]', 'Found form'
    return
  casper.then ->
    @fill 'form[name="deepinid_userbundle_reset_passowrd"]',
      'deepinid_userbundle_reset_passowrd[password]': '987654321'
      'deepinid_userbundle_reset_passowrd[repassword]': '987654321'
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.resetpassword_ok_go_login, 'Find message ' + testTranslator.resetpassword_ok_go_login
    return
  casper.run ->
    test.done()
    return
  return

casper.test.begin 'To test the normal login operation with new password', 9, suite = (test) ->
  casper.start()
  casper.open testUrl.domain + testUrl.login
  casper.then ->
    test.assertExists 'form[name="deepinid_userbundle_user"]', 'Found form'
  casper.then ->
    @fill 'form[name="deepinid_userbundle_user"]',
      'deepinid_userbundle_user[email]': testAccount.email
      'deepinid_userbundle_user[password]': '987654321'
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.login_ok, "Login SUCCESS " + testTranslator.login_ok
    @open testUrl.domain + testUrl.logout
    return
  casper.then ->
    test.assertTextExists testTranslator.deepin_user_center, 'Found text ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.save_logout_success, 'Found text ' + testTranslator.save_logout_success
    @open testUrl.domain + testUrl.serverHelp.get_reset_password_check + testAccount.email
    return
  casper.then ->
    serverResult = eval ("(" + @getPageContent() + ")")
    test.assert serverResult.success, serverResult.msg.check
    @echo testUrl.domain + testUrl.resetpassword + '/email/' + testAccount.email + '/t/' + serverResult.msg.t + '/check/' + serverResult.msg.check
    @open testUrl.domain + testUrl.resetpassword + '/email/' + testAccount.email + '/t/' + serverResult.msg.t + '/check/' + serverResult.msg.check
    return
  casper.then ->
    test.assertTextExists testTranslator.deepin_user_center, 'Find message ' + testTranslator.deepin_user_center
    test.assertTextExists testTranslator.set_new_password, 'Find message ' + testTranslator.set_new_password
    test.assertExists 'form[name="deepinid_userbundle_reset_passowrd"]', 'Found form'
    return
  casper.then ->
    @fill 'form[name="deepinid_userbundle_reset_passowrd"]',
      'deepinid_userbundle_reset_passowrd[password]': testAccount.password
      'deepinid_userbundle_reset_passowrd[repassword]': testAccount.password
    , true
    return
  casper.then ->
    test.assertTextExists testTranslator.resetpassword_ok_go_login, 'Find message ' + testTranslator.resetpassword_ok_go_login
    return
  casper.run ->
    test.done()
    return
  return
