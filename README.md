# What's this
[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)

My home network configuration.
Currently consists of a single Mikrotik hAP ax<sup>3</sup>.

# Note to future self
Hopefully Mikrotik doesn't break their API and that you can connect to the router through SSH.
Then you can run:

```sh
ansible-playbook --ask-vault-pass --inventory hosts.yml playbook.yml 
```

## Modifing passwords/AP names

```sh
ansible-vault edit host_vars/mikrotik-hap-ax3/vault
```

Remember to set NVIM as your editor! Otherwise might not work :)

# TODO
- Would be nice to add some visual representations of the setup
