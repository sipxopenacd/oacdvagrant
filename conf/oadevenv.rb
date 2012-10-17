require 'rubygems'
require 'mechanize'

$admin_username = 'superadmin'
$admin_password = 'superadmin'

$sipxconfig_url = 'http://10.24.7.87:12000/sipxconfig/'

def login(username=nil, password=nil, a=nil)
	a = Mechanize.new if a.nil?
	username = $admin_username if username.nil?
	password = $admin_password if password.nil?

	login_p = a.get($sipxconfig_url)
	login_f = login_p.form_with(:action => "/sipxconfig/j_acegi_security_check")

	throw :login_not_found if login_f.nil?

	login_f['j_username'] = username
	login_f['j_password'] = password
	login_f.submit
end
