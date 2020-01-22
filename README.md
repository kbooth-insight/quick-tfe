# quick-tfe

This will setup a multi-node TFE instance in virtualbox to test on/demo.

There is a host only adapter and a NAT adapter to make it easy to ssh/web without going through vagrant ssh.


## Getting started

1.) Install `vagrant` https://www.vagrantup.com/

2.) Run `vagrant plugin install vagrant-disksize`


3.) Copy license file into repo directory and name it `replicated.rli` (base64 encoded).  This file and all files ending in `*.rli` are ignored, make sure not to check it in some other way.

4.) Run `vagrant up`

5.) Wait for awhile

username will be `admin@local.com` for tfe
password is randomly generated and _in the output of the vagrant up_ for each instance...copy it down so you have it.

