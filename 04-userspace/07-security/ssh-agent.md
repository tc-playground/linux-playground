# ssh-agent

## Introduction

* `ssh-agent` is a helper program that keeps track of user's identity `keys` and their `passphrases`. 

* `ssh-agent` can then use the keys to log into other servers without having the user type in a password or passphrase again. 

* `ssh-agent` implements a form of single sign-on (SSO) via `SSH Forwarding`.

* `ssh-agent` is not started by default.

---

##  Commands

1. __Start ssh-agent__ : `eval $(ssh-agent)`

2. __Check ssh-agent__ : `echo $SSH_AGENT_SOCK`

3. __List ssh-agent managed keys__ : `ssh-add -l`

4. __Add ssh key ssh-agent__ : `ssh-add ${path/to/key}`

---

## Configuration

1. `ssh-agent` is not started by default. Add `eval $(ssh-agent)` to an appropriate init file (e.g. `${HOME}/.profile`)

2. __Environment__

    * `${SSH_AGENT_PID}`

    * `${SSH_AGENT_SOCK}`

---

## References

* [SSH Agent Tutorial](https://www.ssh.com/ssh/agent)

* [SSH Key Management](https://www.ssh.com/iam/ssh-key-management/)