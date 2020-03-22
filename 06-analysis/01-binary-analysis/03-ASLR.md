# ASLR - Address Space Layout Randomization

## Introduction

* `ASLR` is a computer security technique involved in preventing exploitation of memory corruption vulnerabilities. 

* `ASLR` prevent an attacker from reliably jumping to a particular exploited function in memory. 

* `ASLR` randomly arranges the address space positions of key data areas of a process:

    * The base address of the `executable`. 
    
    * The base address of the `stack`.
    
    * The base address of the `heap`.
    
    * The base address of the `libraries`. 

---

## References

* [ASLR - Wikipedia](https://en.wikipedia.org/wiki/Address_space_layout_randomization)

