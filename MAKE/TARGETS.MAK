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


$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) -c $(CFLAGS) -o $@ $<

$(BUILDROOT)/%.o: $(SRCDIR)/%.s
	$(AS)  $(INC) $(AFLAGS) -o $@ $<

#===============================================================================
# Generic build root for library
#===============================================================================
$(LIBRARY): $(OBJS) | $(SUBMODULES) asmobjs
	$(AR) $(LIBRARY) $?

#===============================================================================
# 
#===============================================================================
asmobjs: $(AOBJS)

#===============================================================================
# Build submodules dirs of a library.  This is to allow multi levels to a top 
# level module
#===============================================================================
.PHONY: $(SUBMODULES)
$(SUBMODULES):
	@echo =============================================================================
	@echo "    "BUILDING $@
	@echo =============================================================================
	$(MAKE) SRCDIR=$(SRCDIR)/$@ BUILDROOT=$(BUILDROOT) BUILDDIR=$(BUILDDIR)/$@ -C $@ -f Makefile

$(SUBDIRS):
	@echo =============================================================================
	@echo "    "BUILDING $@
	@echo =============================================================================
	mkdir -p $(BUILDDIR)/$@
	$(MAKE) SRCDIR=$(SRCDIR)/$@ BUILDROOT=$(BUILDROOT) BUILDDIR=$(BUILDDIR)/$@ -C $@ -f Makefile

.PHONY: clean local_clean_objs local_clean_aobjs local_lib submodule_clean subdir_clean
local_clean_objs:
	$(foreach fileToDelete, $(OBJS), rm -f $(fileToDelete);)

local_clean_aobjs:
	$(foreach fileToDelete, $(AOBJS), rm -f $(fileToDelete);)

local_clean_lib:
	rm -f $(LIBRARY);

submodule_clean:
	$(foreach subdir, $(SUBMODULES), $(shell make BUILDROOT=$(BUILDROOT) BUILDDIR=$(BUILDDIR)/$(subdir)  -C $(subdir) clean))

subdir_clean:
	$(foreach subdir, $(SUBDIRS), $(shell make BUILDROOT=$(BUILDROOT) BUILDDIR=$(BUILDDIR)/$(subdir) -C $(subdir)  clean))
