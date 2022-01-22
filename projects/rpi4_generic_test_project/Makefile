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

.PHONY: clean all nite_owl 

all: nite_owl 

include $(SRCROOT)/MAKE/TARGETS.MAK

nite_owl: BUILDDIR = $(SRCROOT)/build/nite_owl
nite_owl: BUILDROOT = $(SRCROOT)/build/nite_owl
nite_owl: SRCDIR = $(SRCROOT)
nite_owl: NITE_OWL_SUBMODULES_
	@echo =============================================================================
	@echo "    "BUILDING $@
	@echo =============================================================================
	$(LD) $(LFLAGS) -o $(BUILDROOT)/nite_owl.elf -T platform.ld $(BUILDROOT)/entry.o -L$(BUILDROOT) $(LIBS) $(LIBS)
	$(OBJCOPY) -O binary $(BUILDDIR)/nite_owl.elf $(BUILDDIR)/nite_owl.bin 


clean: 
	rm -rf $(SRCROOT)/build