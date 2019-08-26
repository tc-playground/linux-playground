#!/bin/bash

# Linux dependencies
# 
function apt-install-deps() {
    sudo apt install binutils gcc grub-common make nasm xorriso
} && apt-install-deps

