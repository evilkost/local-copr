Local copr installation
=======================

Purpose: testing, show-case.
Not realy production ready, you still need to read/edit some files, become familiar with copr components.


Host machine requirements
=========================

- docker
- virtualbox
- vagrant
- [ base builder image ]


Design
======

- copr-frontend and copr-backend are executed inside docker, referenced as `front` and `back`
- `back` has ssh access to the host machine where it spawns builder VMs using vagrant
- `back` has access to `front` through docker linking


Setup
=====

Common
------

- select(create) a user on host ($USER) machine which should be able to use docker, vargrant, virtualbox
- execute `add_lo_ip_addrs.sh` to add local IPs to bind dockerised HTTP servers to.
- add content of `etc-hosts-addition` to your /etc/hosts for convinience

Front
-----

- `cd docker-copr-backend`
- build docker image using command:

    `docker build -t test_front `


- run `front` using script `docker-copr-frontend/run_frontend.sh`
- you should be able to see Copr running in browser at `http://front.test`

Back & VM provider
------------------

- `cd docker-copr-backend`
- generate ssh keypair, so that builder could ssh to the host, copy private key to `builder_id_rsa`
- [ - replace `cloud/ssh_keys/vagrant_insecure_privkey` if it was changed by vagrant or your distribution]
- do `cp cloud/priv_vars.yml{.example,}` and replace username with $USER
- edit `cloud/vars.yml` to select vagrant source boxes.
To improve performance create your own vagrant box from provisioned instance.
If you changed variable `base_img_name` update line `  config.vm.box = "f20_builder"` in `cloud/Vagrantfile`

- build docker image using command:

    `docker build -t test_back`


- `back` should be able to process builds

Notes
=====

I was forced to disable SELinux on host, it prevented ssh connection from docker to host/builder VM.
Troubleshooting tool was unable to generate semodule to allow such connection. 
If somebody has ideas how to fix it and re-enable SELinux please ping me.



