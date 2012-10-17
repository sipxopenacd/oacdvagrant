Vagrant for SipX/OpenACD Dev
============================

The steps for initial setup are documented [here](https://github.com/sipxopenacd/oacdvagrant/wiki/Initial-setup).

For succeeding runs, execute:
```sh
vagrant up
```

then inside your VM, start OpenACD:
```sh
oa
```

To build OpenACD and its plugins after a code update, execute `mkoa` inside your VM then restart OpenACD.
