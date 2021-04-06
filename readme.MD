# Oscilloscope Digital Phosfor Tester

Test of the oscilloscope's ability to display rare events

50 MHz div 3 = 16,666 Its ~= 16777216 - 24 bit binary counter with 1s period

16 MHz / 16 => 10 MHz 

                    +---------------+  ...    ...   +--
                    |  | |    | |   |  | |    | |   | 
                  --+  ...    ...   +---------------+

  1 spike per second    -^
  2 spike per second           -^
  4 spike per second                    -^
  8 spike per second                          -^

# Debug

To generate wave

  ./make_wave.sh

To open wave

  gtkwave ./bench.vcd

