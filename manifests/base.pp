$vagrant_dir = '/vagrant'
$conf_dir = '/home/vagrant/conf'

# SELinux
file { '/etc/selinux/config': source => "$conf_dir/selinux", }
service { 'iptables': ensure => 'stopped', hasstatus => true, }

# sipXecs

yumrepo { 'sipXecs-stable':
  name => 'sipXecs-stable',
  baseurl => 'http://download.sipfoundry.org/pub/release-4.6.0-stable/4.6.0/Fedora_$releasever/$basearch',
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
'net-snmp-utils', 'ntp', 'patch', 'pcre',
'postgresql-odbc', 'postgresql-server', 'redis', 'rpm', 'rpm-libs',
'ruby-dbi', 'rubygem-daemons', 'rubygem-file-tail', 'rubygem-net-sftp',
'ruby-libs', 'ruby-postgres', 'sec', 'sendmail', 'sendmail-cf',
'stunnel', 'system-config-network-tui', 'tftp', 'tftp-server',
'unixODBC', 'vsftpd', 'which', 'xerces-c', 'libtool',
'resiprocate-devel']

# missing build deps: irb, java, java-fonts

package { $sipx_build_deps: ensure => "installed", require => Yumrepo['sipXecs-stable'] }

# rpm build
package {'rpm-build': ensure => installed,}
package {'fedora-packager': ensure => installed,}

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

package {'ImageMagick-devel': ensure => installed }
package {'rmagick': ensure => installed, provider => 'gem', require => Package['ImageMagick-devel'] }

package {'json': ensure => installed, provider => 'gem'}
package {'rest-client': ensure => installed, provider => 'gem'}

package {'genghisapp': ensure => installed, provider => 'gem'}

exec {'/home/vagrant/bin/installerlanghistory':
  creates => '/usr/lib/erlang/lib/kernel-2.15.2/ebin/group.beam.backup-pre-shell-history',
  path => '/bin:/usr/bin'
}

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

# oacd conf
file { '/home/vagrant/workspace/oacd/conf/sys.config':
  ensure => 'link',
  target => '/home/vagrant/conf/oacd/sys.config'
}
file { '/home/vagrant/workspace/oacd/conf/oacd.cfg':
  ensure => 'link',
  target => '/home/vagrant/conf/oacd/oacd.cfg'
}

# Etc

file { '/etc/hosts':
	source => '/home/vagrant/conf/hosts'
}

# Nodejs

exec {
  'get nodejs source code':
    command => '/usr/bin/wget http://nodejs.org/dist/v0.8.15/node-v0.8.15.tar.gz -O /tmp/node-v0.8.15.tar.gz',
    unless => '/bin/ls /usr/local/bin/node';
  'untar nodejs':
    command => '/bin/tar -zxf /tmp/node-v0.8.15.tar.gz -C /tmp',
    unless => '/bin/ls /usr/local/bin/node',
    require => Exec['get nodejs source code'];
  'configure nodejs':
    command => "/bin/sh -c './configure'",
    cwd => "/tmp/node-v0.8.15",
    unless => '/bin/ls /usr/local/bin/node',
    require => Exec['untar nodejs'];
  'make nodejs':
    command => '/usr/bin/make -C /tmp/node-v0.8.15',
    unless => '/bin/ls /usr/local/bin/node',
    require => Exec['configure nodejs'];
  'make install nodejs':
    command => '/usr/bin/make install -C /tmp/node-v0.8.15',
    unless => '/bin/ls /usr/local/bin/node',
    require => Exec['make nodejs']
}
