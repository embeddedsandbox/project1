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

include ./MAKE/RULES.MAK


SUBMODULES	:= rpi4-bsp
CSRC		:=
ASRC		:=
BUILDDIR	:= $(CURDIR)/build
SRCDIR		:= $(CURDIR)

# Should probably just export these two instead of passing them down. 
export SRCROOT		:= $(CURDIR)
export BUILDROOT 	:= $(CURDIR)/build

.PHONY: clean all submodule_build_dirs nite_owl qemu_sim

all: submodule_build_dirs nite_owl qemu_sim


include ./MAKE/TARGETS.MAK

submodule_build_dirs:
	$(foreach submod, $(SUBMODULES), mkdir -p $(BUILDROOT)/$(submod);)

nite_owl: $(SUBMODULES)
	@echo =============================================================================
	@echo "    "BUILDING $@
	@echo =============================================================================
	$(LD) $(LFLAGS) -o $(BUILDROOT)/nite_owl.elf -T platform.ld $(BUILDROOT)/entry.o -L$(BUILDROOT) --library=platform  
	$(OBJCOPY) -O binary $(BUILDDIR)/nite_owl.elf $(BUILDDIR)/nite_owl.bin 


# Note this isn't locating the different parts in the right places yet. probably need a linker script to get this right. 
qemu_sim: nite_owl
	@echo =============================================================================
	@echo "    "BUILDING $@
	@echo =============================================================================
	$(LD) -o $(BUILDROOT)/qemu_sim.elf -T qemu_sim.ld

clean: 
	$(foreach sub, $(SUBMODULES), $(MAKE) BUILDROOT=$(BUILDROOT)  BUILDDIR=$(BUILDDIR)/$(sub) -C $(sub) clean)
	rm -f $(BUILDROOT)/*.elf
	rm -f $(BUILDROOT)/*.bin