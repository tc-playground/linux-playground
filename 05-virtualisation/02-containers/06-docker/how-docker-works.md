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

## Investigate Docker Container Process Tree

1. __Container__ - Start a container:  `docker run -dt --name debian debian` && `docker exec -it debian /bin/bash`

    *  - Then run a `watch` command.

        ```bash
        root@467a84c1020b:/# watch ps ax
        PID TTY      STAT   TIME COMMAND
            1 pts/0    Ss+    0:00 bash
            9 pts/1    Ss     0:00 /bin/bash
        3350 pts/1    R+     0:00 ps ax
        ``` 

2.  __Host__ - Then view the `watch` process int he container from the host.

    ```bash
    $> pstree -p
    systemd(1)─┬─ModemManager(1067)─┬─{ModemManager}(1144)
            │                       └─{ModemManager}(1161)
            .
            ├─dockerd(2258)─┬─docker-containerd(2328)─┬─docker-containerd-shim(16659)─┬─bash(16679)
            │               │                         │                               ├─bash(16768)───watch(20009)
    ```

    ```bash
    $> pstree -aptl -s 2258
    systemd,1 splash
    └─dockerd,2258 -H fd://
        ├─docker-containe,2328 --config /var/run/docker/containerd/containerd.toml
        │   ├─docker-containe,16659 -namespace moby -workdir /var/lib/docker/containerd/daemon/io.containerd.runtime.v1.linux/moby/467a84c1020b2f01ee9633540e479b873697e903546d7b790cf258ce0eb533e8 -address /var/run/docker/containerd/docker-containerd.sock -containerd-binary /usr/bin/docker-containerd -runtime-root /var/run/docker/runtime-runc
        │   │   ├─bash,16679
        │   │   ├─bash,21612
        │   │   │   └─watch,21631 ps ax
    ```

3. __Parent Processes__

    * `systemd (1)` -> `containerd (33692)` -> `containerd-shim (7259)` ->  `bash (18694)` -> `watch (18792)`

        > `systemd` clones, forks, execs to produce the new containerised process.

    * `containerd` - is a daemon / service for managing containers (`container runtime`). (Linux/Windows)

        * It manages the complete container life-cycle of its host system, from image transfer and storage to container execution and supervision to low-level storage to network attachments and beyond. 

    * `containerd-shim` - An implementation of `containerd`

        * `runc`

        * `runhcs`

        * `kata`

        * `firecracker`

        * `gVisor`

        * `dShim`

---

## Investigate Docker Container Creation System Calls

1. Attach to the `docker-containerd` service and perform an `strace`.

    ```bash
    sudo strace -f -p `pidof docker-containerd` -o strace_log
    ```

2. Create a container

    ```bash
    docker run -dt --name debian debian
    ```

3. Search for `execve` calls:

    ```bash
    cat strace_log | less | grep execve

    5008  execve("/usr/bin/docker-containerd-shim", ["docker-containerd-shim", "-namespace", "moby", "-workdir", "/var/lib/docker/containerd/daemo"..., "-address", "/var/run/docker/containerd/docke"..., "-containerd-binary", "/usr/bin/docker-containerd", "-runtime-root", "/var/run/docker/runtime-runc"], 0xc420661e30 /* 4 vars */ <unfinished ...>

    5017  execve("/usr/bin/docker-runc", ["docker-runc", "--root", "/var/run/docker/runtime-runc/mob"..., "--log", "/run/docker/containerd/daemon/io"..., "--log-format", "json", "create", "--bundle", "/var/run/docker/containerd/daemo"..., "--pid-file", "/run/docker/containerd/daemon/io"..., "--console-socket", "/tmp/pty380604172/pty.sock", "8519c5cc571be107cf3fa427d536a480"...], 0xc42010e480 /* 4 vars */ <unfinished ...>

    5024  execve("/proc/self/exe", ["docker-runc", "init"], 0xc4201ab0e0 /* 4 vars */ <unfinished ...>

    5043  execve("/proc/2276/exe", ["libnetwork-setkey", "8519c5cc571be107cf3fa427d536a480"..., "ee0dc9e87bc8f5afdc11c73d0c1a3ffa"...], 0xc420260510 /* 4 vars */ <unfinished ...>

    5069  execve("/usr/bin/docker-runc", ["docker-runc", "--root", "/var/run/docker/runtime-runc/mob"..., "--log", "/run/docker/containerd/daemon/io"..., "--log-format", "json", "state", "8519c5cc571be107cf3fa427d536a480"...], 0xc42010e540 /* 4 vars */ <unfinished ...>

    5076  execve("/usr/bin/docker-runc", ["docker-runc", "--root", "/var/run/docker/runtime-runc/mob"..., "--log", "/run/docker/containerd/daemon/io"..., "--log-format", "json", "start", "8519c5cc571be107cf3fa427d536a480"...], 0xc42010e750 /* 4 vars */ <unfinished ...>

    5031  execve("/bin/bash", ["bash"], 0xc420175890 /* 4 vars */ <unfinished ...>
    ```

4. Search for `unshare` calls:

    ```bash
    cat strace_log | less | grep execve

    6269  prctl(PR_SET_NAME, "runc:[1:CHILD]") = 0
    6269  unshare(CLONE_NEWNS|CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|CLONE_NEWPID) = 0
    ```

5. Run `man unshare` to view info on unshare

6. Compare Namespaces

* Init Process Namespaces

    ```bash
    $> sudo ls -lah /proc/1/ns
    [sudo] password for temple: 
    total 0
    dr-x--x--x 2 root root 0 Mar  3 11:20 .
    dr-xr-xr-x 9 root root 0 Mar  3 11:20 ..
    lrwxrwxrwx 1 root root 0 Mar  3 11:47 cgroup -> 'cgroup:[4026531835]'
    lrwxrwxrwx 1 root root 0 Mar  3 11:47 ipc -> 'ipc:[4026531839]'
    lrwxrwxrwx 1 root root 0 Mar  3 11:20 mnt -> 'mnt:[4026531840]'
    lrwxrwxrwx 1 root root 0 Mar  3 11:47 net -> 'net:[4026532008]'
    lrwxrwxrwx 1 root root 0 Mar  3 11:47 pid -> 'pid:[4026531836]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:16 pid_for_children -> 'pid:[4026531836]'
    lrwxrwxrwx 1 root root 0 Mar  3 11:47 user -> 'user:[4026531837]'
    lrwxrwxrwx 1 root root 0 Mar  3 11:47 uts -> 'uts:[4026531838]'
    ```

* Current Shell Process Namespaces

    ```bash
    $> sudo ls -lah /proc/$$/ns
    total 0
    dr-x--x--x 2 temple temple 0 Mar  3 12:55 .
    dr-xr-xr-x 9 temple temple 0 Mar  3 12:15 ..
    lrwxrwxrwx 1 temple temple 0 Mar  3 12:55 cgroup -> 'cgroup:[4026531835]'
    lrwxrwxrwx 1 temple temple 0 Mar  3 12:55 ipc -> 'ipc:[4026531839]'
    lrwxrwxrwx 1 temple temple 0 Mar  3 12:55 mnt -> 'mnt:[4026531840]'
    lrwxrwxrwx 1 temple temple 0 Mar  3 12:55 net -> 'net:[4026532008]'
    lrwxrwxrwx 1 temple temple 0 Mar  3 12:55 pid -> 'pid:[4026531836]'
    lrwxrwxrwx 1 temple temple 0 Mar  3 22:18 pid_for_children -> 'pid:[4026531836]'
    lrwxrwxrwx 1 temple temple 0 Mar  3 12:55 user -> 'user:[4026531837]'
    lrwxrwxrwx 1 temple temple 0 Mar  3 12:55 uts -> 'uts:[4026531838]'
    ```

* Container `watch` Process - Namespaces - DIFFERENT (except `user`)!

    ```bash
    519 temple@occam:~
    $> ps aux | grep watch
    root       170  0.0  0.0      0     0 ?        S    11:20   0:00 [watchdogd]
    temple    4371  0.0  0.2 438536 78156 ?        Sl   11:21   0:02 /usr/share/code/code /usr/share/code/resources/app/out/bootstrap-fork --type=watcherService
    root      8476  0.0  0.0   2856  2308 pts/1    S+   22:04   0:00 watch ps aux
    temple   10116  0.0  0.0   9032   916 pts/3    S+   22:20   0:00 grep watch
    520 temple@occam:~
    $> sudo ls -lah /proc/8476/ns
    total 0
    dr-x--x--x 2 root root 0 Mar  3 22:12 .
    dr-xr-xr-x 9 root root 0 Mar  3 22:11 ..
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 cgroup -> 'cgroup:[4026531835]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 ipc -> 'ipc:[4026533423]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 mnt -> 'mnt:[4026533421]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 net -> 'net:[4026533426]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 pid -> 'pid:[4026533424]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 pid_for_children -> 'pid:[4026533424]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 user -> 'user:[4026531837]'
    lrwxrwxrwx 1 root root 0 Mar  3 22:14 uts -> 'uts:[4026533422]'
    ```

---

## References

* [Docker Docs](https://docs.docker.com/)

    * [Overview](https://docs.docker.com/engine/docker-overview/)

* [Intro to Docker](https://www.youtube.com/watch?v=cPGZMt4cJ0I) / [CTF challenges](https://www.youtube.com/watch?v=OqTpc_ljPYk&feature=youtu.be)

* [How Docker Works - namespaces](https://www.youtube.com/watch?v=-YnMr1lj4Z8)

* [How Docker Works - nsenter](https://www.youtube.com/watch?v=sHp0Q3rvamk)

* [containerd](https://containerd.io/)

    * [containerd Github](https://github.com/containerd/containerd)

* [runc](https://github.com/opencontainers/runc) - CLI tool for spawning and running containers according to the [OCI specification](https://www.opencontainers.org/)

* [hcsshim](https://github.com/Microsoft/hcsshim) - Windows - Host Compute Service Shim 

* [Linux Device Drivers](https://www.youtube.com/watch?v=juGNPLdjLH4)

* [Deep Dive - Docker Overlay Networks](https://www.youtube.com/watch?v=b3XDl0YsVsg)

* [Namespace - LWN](https://lwn.net/Articles/531114/) - 7 parts.

* [Linux Container from Scratch](https://medium.com/@flag_seeker/linux-container-from-scratch-339c3ba0411d)

* [Bocker - Bash Docker Implementation](https://github.com/p8952/bocker/)

* [Kernel SysCalls](https://elixir.bootlin.com/linux/latest/source/kernel/sys.c#L891)

* [Privileged Containers](https://pulsesecurity.co.nz/articles/docker-rootkits)