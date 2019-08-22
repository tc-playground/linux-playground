# `CRI-O` - Lightweight pluggable container runtime for Kubernetes

## Introduction

* `CRI-O` an OCI (Open Container Initiative) based implementation of Kubernetes Container Runtime Interface.

* `CRI-O`  allows `Kubernetes` to use any `OCI-compliant runtime` as the `container runtime` for `running pods`. 

---

## Features

* `CRI-O` is an implementation of the Kubernetes CRI (Container Runtime Interface) to enable using OCI (Open Container Initiative) compatible runtimes. 

* `CRI-O` is a lightweight alternative to using Docker as the runtime for `Kubernetes`. 

* `CRI-O`  allows `Kubernetes` to use any `OCI-compliant runtime` as the `container runtime` for `running pods`. 

* `CRI-O` supports `runc` and `Kata Containers` as the container runtimes but any OCI conformant in principle any runtime can be plugged in.

* `CRI-O` supports OCI container images and can pull from any container registry. It is a lightweight alternative to using Docker, Moby or rkt as the runtime for Kubernetes.* `Kata Containers` is based on `Intel Clear Containers` and `Hyper runV` technology.


---

## Use Cases

* `CRI-O` is typically used in a `Kubernetes` cluster as the `container runtime` for the `kubelet` (instead of `docker`).

---

## References

* [Home](https://cri-o.io/)

* [Github](https://github.com/cri-o/cri-o)

* [OCI Runtime Specification](https://github.com/opencontainers/runtime-spec)

* [OCI Image Specification](https://github.com/opencontainers/image-spec)
