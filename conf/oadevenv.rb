require 'rubygems'
require 'mechanize'

$admin_username = 'superadmin'
$admin_password = 'superadmin'

$sipxconfig_url = 'http://10.24.7.87:12000/sipxconfig/'

def login(a=nil)
	a = Mechanize.new if a.nil?

	login_p = a.get($sipxconfig_url)
	login_f = login_p.form_with(:action => "/sipxconfig/j_acegi_security_check")

	throw :login_not_found if login_f.nil?

	login_f['j_username'] = $admin_username
	login_f['j_password'] = $admin_password
	login_f.submit
end
