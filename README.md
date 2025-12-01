# UVM with Verilator example

Copyright (c) 2025 Antmicro

This is a basic example of how to use [UVM](https://www.accellera.org/downloads/standards/uvm) with [Verilator](https://github.com/verilator/verilator).

First, we need to build Verilator.
You may need to install some dependencies:

```sh
sudo apt update -y
sudo apt install -y bison flex libfl-dev help2man z3
# You may already have these:
sudo apt install -y git autoconf make g++ perl python3
```

Then, clone and build latest Verilator:

```sh
git clone https://github.com/verilator/verilator
pushd verilator
autoconf
./configure
make -j `nproc`
popd
```

For the full instructions, visit Verilator's [documentation](https://verilator.org/guide/latest/install.html).

Next, download the UVM code:
```sh
wget https://www.accellera.org/images/downloads/standards/uvm/Accellera-1800.2-2017-1.0.tar.gz
tar -xvzf Accellera-1800.2-2017-1.0.tar.gz
```

Now, set up the `UVM_HOME` environment variable to point to the extracted UVM sources.
We also need `PATH` to point to Verilator:

```sh
UVM_HOME="$(pwd)/1800.2-2017-1.0/src"
PATH="$(pwd)/verilator/bin:$PATH"
```

To build the simulation, run:

```sh
verilator -Wno-fatal --binary --output-groups $(nproc) -j $(nproc) \
    --top-module tbench_top +incdir+$UVM_HOME +define+UVM_NO_DPI +incdir+$(pwd) \
    $UVM_HOME/uvm_pkg.sv $(pwd)/sig_pkg.sv $(pwd)/tb.sv
```

Finally, run the simulation:

```sh
./obj_dir/Vtbench_top +UVM_TESTNAME=sig_model_test
```
