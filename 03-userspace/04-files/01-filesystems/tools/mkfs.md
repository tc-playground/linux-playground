# `mkfs` - Build a Linux filesystem

## Introduction

> NB: The `mkfs` frontend is deprecated in favour of filesystem specific `mkfs.<type>` utilities programs.

* `mkfs` is used to build a Linux `filesystem` of the specified `type` on a specified `device` (usually a hard disk partition).

* `mkfs` has filesystem specific support programs: `mkfs.ext4`, `mkfs.btrfs`, etc.
---

## Use-cases

* `mkfs` can be used create `filesystem metadata` so that it can be `mounted` to a `device`.

---

## Reference

* [Man dump/8](https://linux.die.net/man/8/dump)