# We don't need kludgy automatizations here,
# let's use a simple Makefile.
# Just tweak the values below to fix your paths


CPP = g++
CXX = g++
LINKER = ld




# debugging flags:
CXXFLAGS = -Wall -ggdb -I../../slw -I. -I/usr/pkg/include -DHAVE_BSD

# optimized flags:
# CXXFLAGS = -Wall -O2 -fomit-frame-pointer -ffast-math -I../slw -I. -I/usr/pkg/include -DHAVE_BSD

# Darwin/OSX flags: uncomment all below and comment the rest
# CPPFLAGS = -pipe -Wall -ggdb -I../slw -I. -I/sw/include -L/sw/lib -DHAVE_BSD

# flags to compile slang linking to dynamic system lib

LIBS = -lslang -lpthread ../../slw/libslw.a

# flags to compile slang linking to dynamic libs on BSD

#LIBS = -L/usr/pkg/lib -lpthread -lslang ../slw/libslw.a 

# flags to include static slang library from the source
# (need to provide the full path to your libslang.a)
#SLANGPATH  = ../slang-2.0.6
#CPPFLAGS = -Wall -ggdb
#CXXFLAGS = -Wall -ggdb -I. -I$(SLANGPATH)/src
#LIBS = $(SLANGPATH)/src/objs/libslang.a -ltermcap

# flags to compile with memodebugging

DEPS = tbt.o linklist.o jutils.o rtclock.o


# generic make rules
#%.o: %.cpp
#	$(CXX) $(CXXFLAGS) -c -o $@ $<
#%: %.cpp
#	$(CXX) $(CXXFLAGS) -o $@ $< $(DEPS) $(LIBS)

all: tbt

depend:
	mkdep $(CXXFLAGS) tbt.cpp cmdline.cpp

tbt: cmdline.o $(DEPS)
	$(CXX) $(CXXFLAGS) -o tbt cmdline.o $(DEPS) $(LIBS)
	ln -sf tbt rectext
	ln -sf tbt playtext
	ln -sf tbt recmail

recmail: recmail.o $(DEPS)
	$(CPP) $(CXXFLAGS) -o recmail recmail.o $(DEPS) $(LIBS)

tbtcheck: $(DEPS) tbtcheck.o
	$(CPP) $(CXXFLAGS) -o tbtcheck tbtcheck.o $(DEPS) $(LIBS)

tbtcheck_ascii: $(DEPS) tbtcheck_ascii.o
	$(CPP) $(CXXFLAGS) -o tbtcheck_ascii tbtcheck_ascii.o $(DEPS) $(LIBS)

rtctest: $(DEPS) rtctest.o
	$(CPP) $(CXXFLAGS) -o rtctest rtctest.o $(DEPS) $(LIBS)

clean:
	rm -rf *.o *~ tbt
	rm -f record.tbt
	find . -type l -exec rm -f {} \;
	make -C web clean
#%: %.c

#	$(CC) $(CFLAGS) -o $@ $< $(LIBS)
#%.o: %.c
#	$(CC) $(CFLAGS) -c -o $@ $<

