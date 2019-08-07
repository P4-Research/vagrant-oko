#!/usr/bin/env bash

# Build DPDK
cd /home/vagrant/
wget http://dpdk.org/browse/dpdk/snapshot/dpdk-16.04.zip
unzip dpdk-16.04.zip
export DPDK_DIR=/home/vagrant/dpdk-16.04
cd $DPDK_DIR

export DPDK_TARGET=x86_64-native-linuxapp-gcc
export DPDK_BUILD=$DPDK_DIR/$DPDK_TARGET
make -j 2 install T=x86_64-native-linuxapp-gcc

cd /home/vagrant/
git clone https://github.com/Orange-OpenSource/oko.git
cd oko/
./boot.sh
./configure --with-dpdk=$DPDK_BUILD
sudo make install

# Note: You may want to append these variables in the `~/.bashrc` file. This way you don't have to execute these whenever you
# open a new terminal.

# Setup DPDK kernel modules
cd /home/vagrant
sudo modprobe uio
sudo insmod $DPDK_BUILD/kmod/igb_uio.ko
sudo insmod $DPDK_BUILD/kmod/rte_kni.ko "lo_mode=lo_mode_ring"

# Add eth1 and eth2 interfaces to DPDK
sudo ifconfig eth1 down
sudo $DPDK_DIR/tools/dpdk_nic_bind.py -b igb_uio eth1
sudo ifconfig eth2 down
sudo $DPDK_DIR/tools/dpdk_nic_bind.py -b igb_uio eth2

# To view these interfaces run the following command:
# $RTE_SDK/tools/dpdk_nic_bind.py --status

# Configure Huge Pages
cd /home/vagrant
sudo mkdir -p /mnt/huge
(mount | grep hugetlbfs) > /dev/null || sudo mount -t hugetlbfs nodev /mnt/huge
echo 1024 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages

# Note: you can verify if huge pages are configured properly using the following command:
# grep -i huge /proc/meminfo

# Create OVS database files and folders
sudo mkdir -p /usr/local/etc/openvswitch
sudo mkdir -p /usr/local/var/run/openvswitch
sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db /usr/local/share/openvswitch/vswitch.ovsschema

