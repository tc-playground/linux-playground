# lsof - 'list open files'

## Introduction

* `lsof` reports a list of all `open files` (including `nw sockets`, etc) and the `process` that opened them.

---

## Examples

* Process that has locked some file: `lsof /path/to/file`

* Open Port Sockets: `sudo lsof -i`

* Open TCP Port Sockets: `lsof -i tcp`

* Open Sockets in Port Range: `lsof -i :1-1024`

---

## References

* [lsof Commands](https://www.howtoforge.com/linux-lsof-command/)
