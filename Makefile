PROGRAM=conaspect
CC ?= gcc
INSTALL ?= install
RM ?= rm -f
PREFIX ?= /usr/local
BINDIR ?= bin
CFLAGS ?= -march=native
# add optimization flags
CFLAGS += -pipe -O3 -ftree-vectorize -fopenmp -fopenmp-simd -pipe -Wno-gnu-alignof-expression -D_FILE_OFFSET_BITS=64 -fdata-sections -fpermissive -ffunction-sections -Wno-array-bounds -Wno-unused-parameter -Wno-pedantic -Wno-narrowing -Wno-attributes
# strip binary
LDFLAGS += -Wl,--gc-sections -Wl,--print-gc-sections -Wl,-s

ifdef _WIN32
OBJECT_EXT ?= .obj
EXECUTABLE_EXT ?= .exe
else
OBJECT_EXT ?= .o
EXECUTABLE_EXT ?= 
endif

all: $(PROGRAM)

$(PROGRAM): $(PROGRAM)$(OBJECT_EXT)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(PROGRAM) $(PROGRAM)$(OBJECT_EXT)

$(PROGRAM)$(OBJECT_EXT): $(PROGRAM).c
	$(CC) $(CFLAGS) -c $(PROGRAM).c

clean:
	if [ -f $(PROGRAM)$(OBJECT_EXT) ]; then $(RM) $(PROGRAM)$(OBJECT_EXT); fi;
	if [ -x $(PROGRAM)$(EXECUTABLE_EXT) ]; then $(RM) $(PROGRAM)$(EXECUTABLE_EXT); fi;

install: $(PROGRAM)
	$(INSTALL) -d $(PREFIX)/$(BINDIR)
	$(INSTALL) -m 755 $(PROGRAM)$(EXECUTABLE_EXT) $(PREFIX)/$(BINDIR)

uninstall: $(PROGRAM)
	$(RM) -f $(PREFIX)/$(BINDIR)/$(PROGRAM)$(EXECUTABLE_EXT)
