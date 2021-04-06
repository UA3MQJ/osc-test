#!/bin/bash
iverilog -o test -I./ -y./ testbench.v
vvp test
