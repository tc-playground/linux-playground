# How Docker Works

## Introduction

* `docker` is a command line tool for managing  `containers` (or `linux namespaces`) via the `docker daemon`.

* `docker` is a command line tool for managing  `container images` (or `linux namespaces`) via the `docker daemon`.

* `docker compose` is a command line tool for creating and managing `multiple containers working together` via the `docker daemon`.

* The `docker daemon` is `unix socket` based service that manipulates linux kernel features `namespaces`, `cgroups`, `seccomp`, etc. to implement `containers`.

* A `dockerfile` is a mechanism for building a `docker image`. 

* A `docker image` is the the filesystem image for a `containerised init process`.

---

## Some Commands

* `sudo docker build -t some-image:some-tag .` - Build a new image.

* `sudo docker docker run -v $PWD:/app -cap-add=SYS_PTRACE --security-opt seccomp=unconfined -i some-image:some-tag` - Run an image that is `gdb` debugable.

* `sudo docker exec -it some-image  /bin/bash` - Spawn/Exec a new process inside the specified container.

---

## Docker - The underlying technology

* `docker` is written in Go and takes advantage of several features of the Linux kernel to deliver its functionality.

* `docker` uses a technology called `namespaces` to provide the isolated workspace called the `container`.

* `namespaces` provide a layer of isolation. Each aspect of a container runs in a separate namespace and its access is limited to that namespace.

    * The `pid` namespace: Process isolation (PID: Process ID).

    * The `net` namespace: Managing network interfaces (NET: Networking).

    * The `ipc` namespace: Managing access to IPC resources (IPC: InterProcess Communication).

    * The `mnt` namespace: Managing filesystem mount points (MNT: Mount).

    * The `uts` namespace: Isolating kernel and version identifiers. (UTS: Unix Timesharing System).

* `cgroup` limit an application to a specific set of resources.

* `UnionFS` is a file systems that operates by creating layers, making them very lightweight and fast. 

    * `docker` uses multiple `UnionFS` variants, including `aufs`, `btrfs`, `vfs`, and `DeviceMapper`.

* `docker` combines the `namespaces`, `control groups`, and `UnionFS` into a wrapper called a `container format`. 

    * The default container format is `libcontainer`.

---

## Namespace Isolation

* __Processes__ - `ps aux`, `pstree -p`

    1. From _outside_ the container we CAN see the processes _inside_ the container. 
    
    2. From _inside_ the container we CANNOT see the processes _outside_ the container.



---

## References

* [Docker Docs](https://docs.docker.com/)

    * [Overview](https://docs.docker.com/engine/docker-overview/)

* [Intro to Docker](https://www.youtube.com/watch?v=cPGZMt4cJ0I)

* [How Docker Works - namespaces](https://www.youtube.com/watch?v=-YnMr1lj4Z8)

* [How Docker Works - nsenter](https://www.youtube.com/watch?v=sHp0Q3rvamk)

* [Linux Device Drivers](https://www.youtube.com/watch?v=juGNPLdjLH4)

* [Deep Dive - Docker Overlay Networks](https://www.youtube.com/watch?v=b3XDl0YsVsg)