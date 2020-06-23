#!/bin/bash

MACHINE=raspi3
#MACHINE=vexpress-a15
NUM_CPU=4
#NUM_CPU=1
CPU=cortex-a53
KERNELIMAGE=../rpi4-bsp/boot/bootloader.elf


qemu-system-aarch64 -S -s -nographic -M ${MACHINE} -cpu ${CPU}  -kernel ${KERNELIMAGE} -smp ${NUM_CPU}
