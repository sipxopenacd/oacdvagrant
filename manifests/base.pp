$vagrant_dir = '/vagrant'
$conf_dir = '/home/vagrant/conf'

# SELinux
file { '/etc/selinux/config': source => "$conf_dir/selinux", }
service { 'iptables': ensure => 'stopped', hasstatus => true, }

# sipXecs

yumrepo { 'sipXecs-testing':
  name => 'sipXecs-testing',
  baseurl => 'http://download.sipfoundry.org/pub/sipXecs/snapshot/Fedora_$releasever/$basearch',
  gpgcheck => 0,
}

$sipx_build_deps = ['apr-devel', 'automake', 'boost-devel', 'cppunit-devel',
'findutils', 'gcc-c++', 'glibc-headers', 'hiredis-devel', 'httpd', 'httpd-devel',
'java-1.6.0-openjdk-devel', 'libev-devel', 'libxml2', 'libxslt', 'mongodb-devel',
'net-snmp-agent-libs', 'net-snmp-devel', 'net-snmp-libs', 'openfire',
'openssl-devel', 'pcre-devel', 'ruby', 'ruby-devel', 'rubygems', 'shadow-utils',
'swig', 'unixODBC-devel', 'xerces-c-devel', 'zeromq-devel', 'zip', 'bind',
'bind-utils', 'boost', 'cfengine', 'chkconfig', 'dejavu-serif-fonts', 'dhcp',
'fontconfig', 'freeswitch',
'js', 'libev', 'mod_ssl', 'mongodb',
'mongodb-server', 'net-snmp', 'net-snmp-sysvinit',
'net-snmp-utils', 'ntp', 'openssl', 'patch', 'pcre',
'postgresql-odbc', 'postgresql-server', 'redis', 'rpm', 'rpm-libs',
'ruby-dbi', 'rubygem-daemons', 'rubygem-file-tail', 'rubygem-net-sftp',
'ruby-libs', 'ruby-postgres', 'sec', 'sendmail', 'sendmail-cf',
'stunnel', 'system-config-network-tui', 'tftp', 'tftp-server',
'unixODBC', 'vsftpd', 'which', 'xerces-c', 'libtool']

# missing build deps: irb, java, java-fonts

package { $sipx_build_deps: ensure => "installed", require => Yumrepo['sipXecs-testing'] }

# Utils
package {'git': ensure => installed, }
package {'wget': ensure => installed, }
package {'unzip': ensure => installed, }
package {'ack': ensure => installed, }
package {'vim-minimal': ensure => latest, }
package {'vim-enhanced': ensure => installed, require => Package['vim-minimal'], }

$mechanize_deps = ['libxml2-devel', 'libxslt-devel']
package {$mechanize_deps: ensure => installed }
package {'mechanize': ensure => installed, provider => 'gem', require => Package[$mechanize_deps]}

# Home

file { '/home/vagrant/.bashrc':
  owner => 'vagrant',
  group => 'vagrant',
  source => '/home/vagrant/conf/bashrc',
}

file { '/home/vagrant/workspace':
  ensure => 'directory',
  owner => 'vagrant',
  group => 'vagrant',
}

file { '/home/vagrant/backup':
  ensure => 'link',
  target => '/vagrant/backup',
}

# Etc

file { '/etc/hosts':
	source => '/home/vagrant/conf/hosts'
}