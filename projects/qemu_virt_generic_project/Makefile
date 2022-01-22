#==============================================================================
# Copyright 2020 Daniel Boals & Michael Boals
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
# THE SOFTWARE.
#==============================================================================

# Should probably just export these two instead of passing them down. 
export SRCROOT		:= $(CURDIR)/../..

include $(SRCROOT)/MAKE/RULES.MAK

SUBMODULES	:= rtos rpi4-bsp app
CSRC		:=
ASRC		:=
export ARC	= aarch64
export BSP	= rpi4-bsp

LIBS		= $(strip $(patsubst %,-l%,$(SUBMODULES)))


.PHONY: clean all qemu_sim

all: qemu_sim

include $(SRCROOT)/MAKE/TARGETS.MAK


# Note this isn't locating the different parts in the right places yet. probably need a linker script to get this right. 
qemu_sim: BUILDDIR = $(SRCROOT)/build/qemu_sim
qemu_sim: BUILDROOT = $(SRCROOT)/build/qemu_sim
qemu_sim: SRCDIR = $(SRCROOT)
qemu_sim: QEMU_SIM_SUBMODULES_
	@echo =============================================================================
	@echo "    "BUILDING $@
	@echo =============================================================================
	$(LD) $(LFLAGS) -o $(BUILDROOT)/qemu_sim.elf -T qemu_sim.ld $(BUILDROOT)/entry.o -L$(BUILDROOT) $(LIBS) $(LIBS)	

clean: 
	rm -rf $(SRCROOT)/build