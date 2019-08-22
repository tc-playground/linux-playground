# Kata Containers - MicroVMs

## Introduction

* `Kata Containers` is a secure container runtime with lightweight virtual machines that feel and perform like containers.

* `Kata Containers` provide a stronger workload isolation using hardware virtualization technology as a second layer of defense.

---

## Architecture

* `Kata Containers` is based on `Intel Clear Containers` and `Hyper runV` technology.

* `Kata Containers` has six components: 

    * `Agent` 
    
    * `Runtime`
    
    * `Proxy` 
    
    * `Shim` 
    
    * `Kernel`
    
    * `QEMU`

---

## Use Cases

* `Kata Containers` works well in an environment where you need the efficiency of a container stack with a higher level of security than running containers side by side in a single kernel. 

    * `Continuous Integration / Continuous Delivery`

    * `Network functions virtualisation`
    
    * `Edge computing` - Limited resources.
    
    * `Containers as a service`

---

## References

* [Home](https://katacontainers.io/)

* [Github](https://github.com/kata-containers)

* [Overview CBR Online](https://www.cbronline.com/opinion/need-to-know-about-containers)