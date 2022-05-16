#####################################################################
## file        : test makefile for build iverilog project          ##
## author      : zaliasc                                           ##
## date-time   : 05/16/2022                                        ##
#####################################################################

VERILATOR = verilator
ICARUS_SUFFIX =
IVERILOG = iverilog$(ICARUS_SUFFIX)
VVP = vvp$(ICARUS_SUFFIX)

defmacro:=-D
# DDR_ADDR_W = 16
# VERILOG_DEFINE+=$(defmacro)DDR_ADDR_W=$(DDR_ADDR_W)

VERILOG_FILES+=$(wildcard rtl/*.v)
VERILOG_FILES+=$(wildcard simulation/*.v)

VERILOG_INCLUDE = \
	# -I include
all: test_vcd

build: testbench.vvp

test: testbench.vvp
	$(VVP) -N $<

test_vcd: testbench.vvp
	$(VVP) -N $< +vcd +trace +noerror

testbench.vvp: $(VERILOG_FILES)
	$(IVERILOG) $(VERILOG_INCLUDE) $(DEFINE) -o $@ $^
	chmod -x $@

clean:
	rm -rf *.vcd *.vvp

.PHONY: build test test_vcd clean
