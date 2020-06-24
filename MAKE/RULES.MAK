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

#------------------------------------------------------------------------------
# Attempt to auto discover tool chain
#------------------------------------------------------------------------------
UNAME := $(shell uname)

ifeq (Darwin,$(findstring Darwin,$(UNAME)))
OS=MACOS
else ifeq (linux,$(findstring linux, $(UNAME)))
OS=LINUX
else
OS=UNKNOWN
endif 

ifeq (MACOS,$(OS))
CC      := $(shell which aarch64-none-elf-gcc)
AS      := $(shell which aarch64-none-elf-as)
LD      := $(shell which aarch64-none-elf-ld)
AR      := $(shell which aarch64-none-elf-ar) -rcs 
OBJCOPY := $(shell which aarch64-none-elf-objcopy)
endif

ifeq (LINUX,$(OS))
CC      := $(shell which )
AS      := $(shell which )
LD      := $(shell which )
AR      := $(shell which )
OBJCOPY := $(shell which )
endif

#------------------------------------------------------------------------------
# command line options for the various tools
#------------------------------------------------------------------------------
LFLAGS      = -T $(PLATFORMDIR)/target.ld -Map=$(BUILDROOT)/$@.map -L$(BUILDROOT) -static $(LIBS) $(LIBS)
CFLAGS      = -Wall -ggdb -O -nostartfiles -Xlinker "-verbose -gc-sections" -ffunction-sections -std=c99 $(INC) 
CPPFLAGS    = 	
INC         = -I$(ROOTDIR)/include -I$(TARGETDIR) -I$(ROOTDIR)/os/arc/$(ARC)/include -I$(PLATFORMDIR) -I$(PERIPHERALDIR)/include

#------------------------------------------------------------------------------
# patter match rules for compiling the sources
#------------------------------------------------------------------------------
#OBJS        = $(patsubst %.c,%.o,$(CSRC)) $(patsubst %.s,%.o,$(ASRC))

BSPOBJS     = $(patsubst %.s,%.o,$(BSPASRC))
AOBJS		= $(patsubst %, $(BUILDROOT)/%, $(patsubst %.s,%.o,$(ASRC)))
OBJS		= $(patsubst %, $(BUILDDIR)/%, $(patsubst %.c,%.o,$(CSRC))) 

%.o: %.c
	$(CC) -g -c $(CFLAGS) $(CINC) -o $@ $<

%.o: %.s
	$(AS) $(INC) -g $(AFLAGS) -o $@ $<

