bup_url := http://dl.dropbox.com/u/12546190/oacddev/backup/base20121010.tar.gz
bup_name := base20121010.tar.gz

all: co backup/base.tar.gz

co: sipxecs sipxecs/openuc sipxecs/custom

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

.PHONY: all checkout up
