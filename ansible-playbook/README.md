# Ansible playbook

This directory contains an [Ansible](https://www.ansible.com) playbook to deploy arrestwatch to a server.

## User/password configuration

Set your own passwords and tokens to replace the ones in `group_vars/all`.

## Staging

To set up a staging environment configure the host_vars for the staging host:

```
has_ssl: false
environment: staging
```

## Special configuration

The playbook writes files as the postgres user, which requires SSH command pipelining to work successfully. Your `ansible.cfg` needs to contain the following section:

```
[ssh_connection]
pipelining = True
```

## Example

* `pip install ansible`
* `ansible-playbook site.yml -K`