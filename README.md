Vagrant for SipX/OpenACD Dev
============================

The steps for initial setup are documented [here](https://github.com/sipxopenacd/oacdvagrant/wiki/Initial-setup).

For succeeding runs, run `vagrant up` then execute the following inside your VM:
```sh
sipxrestart
oa
```
* Starts sipXecs and OpenACD

To build OpenACD and its plugins after a code update, execute `mkoa` inside your VM then restart OpenACD.
