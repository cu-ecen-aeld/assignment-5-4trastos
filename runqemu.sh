#!/bin/bash
#Script to run QEMU for buildroot as the default configuration qemu_aarch64_virt_defconfig
#Host forwarding: Host Port 10022 ->> QEMU Port 22 
#Author: Siddhant Jajoo.


qemu-system-aarch64 \
    -M virt  \
    -cpu cortex-a53 -nographic -smp 1 \
    -kernel buildroot/output/images/Image \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -netdev user,id=eth0,hostfwd=tcp::10022-:22 \
    -device virtio-net-device,netdev=eth0 \
    -drive file=buildroot/output/images/rootfs.ext4,if=none,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 -device virtio-rng-pci
    net nic \
    -net user,hostfwd=tcp::${HOST_PORT_SSH}-:${GUEST_PORT_SSH},hostfwd=tcp::${HOST_PORT_AESD}-:${GUEST_PORT_AESD} \
    "$@"

# AÑADIR ESTAS LÍNEAS PARA REENVÍO DE PUERTOS:
HOST_PORT_SSH=10022
GUEST_PORT_SSH=22
HOST_PORT_AESD=9000
GUEST_PORT_AESD=9000
