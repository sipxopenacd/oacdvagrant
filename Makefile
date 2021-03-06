bup_url := http://dl.dropbox.com/u/12546190/oacddev/backup/base20121018.tar.gz
bup_name := base20121018.tar.gz

oacd_plugin_dir = oacd/plugins
sipxopenacd_plugins := $(oacd_plugin_dir)/oacd_web $(oacd_plugin_dir)/oacd_freeswitch $(oacd_plugin_dir)/sipxplugin

all: co backup/base.tar.gz

co: sipxecs sipxecs/openuc sipxecs/custom openacd oarpms

sipxecs:
	git clone git@github.com:dhubler/sipxecs.git sipxecs

sipxecs/openuc:
	git clone git@github.com:ezuce/openuc.git sipxecs/openuc

sipxecs/custom:
	git clone git@github.com:ezuce/ezuce.git sipxecs/custom

backup/base.tar.gz:
	mkdir -p backup
	wget -nc -O backup/$(bup_name) -- $(bup_url)
	ln -sf $(bup_name) backup/base.tar.gz

openacd: oacd $(sipxopenacd_plugins) oacd/plugins/oacd_ouc

oacd:
	git clone git@github.com:sipxopenacd/oacd_umbrella.git oacd

oarpms:
	git clone git@github.com:sipxopenacd/oarpms.git oarpms

$(sipxopenacd_plugins):
	mkdir -p sipxopenacd/plugins
	git clone git@github.com:sipxopenacd/$(notdir $@).git $@

oacd/plugins/oacd_ouc:
	mkdir -p sipxopenacd/plugins
	git clone git@github.com:ezuce/oucXopenacdWeb.git oacd/plugins/oacd_ouc

.PHONY: all checkout up openacd
