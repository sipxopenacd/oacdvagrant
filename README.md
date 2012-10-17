Vagrant for SipX/OpenACD Dev
============================

The steps for initial setup are documented [here](https://github.com/sipxopenacd/oacdvagrant/wiki/Initial-setup).

For succeeding runs, run `vagrant up` then start sipXecs and OpenACD by executing the following inside your VM:
```sh
sipxrestart
oa
```

To build OpenACD and its plugins after a code update, execute `mkoa` inside your VM then restart OpenACD.
