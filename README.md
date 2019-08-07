## Oko Test Environment

This repository provides Vagrant files to automate testing of [the Oko switch](https://github.com/Orange-OpenSource/oko) - the Open vSwitch that can be extended with BPF programs at runtime.

The OkoP4 test environment is based on the [PISCES Simulation Environment](https://github.com/P4-vSwitch/vagrant).

### How to run?

The Vagrant scripts create three virtual machines: Switch, Generator and Receiver. The Generator and Receiver are VMs to send & display traffic, which has been processed by the Oko switch. 
The Switch VM runs the Oko switch with two DPDK ports - `eth1` receives packets from the Generator and `eth2` sends them out to the Receiver. 

Clone the `vagrant-oko` repository.

```bash
$ git clone https://github.com/P4-Research/vagrant-oko.git
cd vagrant-oko/
```

Brings up virtual machines.

```bash
$ vagrant up
```

> Note: Make sure that you have enough memory on the host to run the setup (switch ~ 4G, generator/receiver ~ 2G each). Also, VMs are only compatible with VirtualBox, so please make sure this provider is available to vagrant.
> It can take vagrant 10-15 mins to start up the VMs. So sit back, relax, and wait for the setup to complete. :-)

### Examples

You can find several sample BPF programs in the [Oko repository](https://github.com/Orange-OpenSource/oko/tree/master/examples/bpf).
The examples are also located under `/home/vagrant/oko/examples/bpf/` on the Switch VM.

Enjoy!

## Contact

For more information about Oko or this Vagrant setup please contanct:

Paul Chaignon &lt;paul.chaignon@orange.com&gt;

Tomasz Osiński &lt;tomasz.osinski2@orange.com&gt;

