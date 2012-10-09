all: co

co: sipxecs sipxecs/openuc sipxecs/custom

sipxecs:
	git clone git@github.com:dhubler/sipxecs.git sipxecs

sipxecs/openuc:
	git clone git@github.com:ezuce/openuc.git sipxecs/openuc

sipxecs/custom:
	git clone git@github.com:ezuce/ezuce.git sipxecs/custom

.PHONY: all checkout up
