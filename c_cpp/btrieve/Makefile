CC = gcc
LDFLAGS = -lpsqlmif
#CFLAGS = -I../../intf/c
CFLAGS = -I ./c

export PVSW_ROOT=/usr/local/psql
ifndef $(PVSW_ROOT)
	PVSW_ROOT=/usr/local/psql
endif

OSNAME = $(shell uname -s)
OSARCH = $(shell uname -m)

ifeq ($(OSNAME),Linux)
	ifeq ($(OSARCH),x86_64)
		CFLAGS += -DBTI_LINUX_64
		LDFLAGS += -L$(PVSW_ROOT)/lib64
	else
	ifeq ($(OSARCH),aarch64)
		CFLAGS += -DBTI_LINUX_64
		LDFLAGS += -L$(PVSW_ROOT)/lib64
	else
		CFLAGS += -DBTI_LINUX
		LDFLAGS += -L$(PVSW_ROOT)/lib
	endif
	endif
else
	CFLAGS += -DBTI_MACOSX_64
	LDFLAGS += -L$(PVSW_ROOT)/lib64
endif


EXECS = btrsamp loginapi
OBJS = btrsamp.o loginapi.o

default:
	@echo --------------------------------------------------------
	@echo  PSQL
	@echo  Btrieve samples
	@echo 
	@echo  Type \"make all\" to make all executables.
	@echo  Type \"make clean\" to remove object files.
	@echo  Type \"make cleanall\" to remove all non-source files.
	@echo --------------------------------------------------------

all: $(EXECS)

btrsamp: 
loginapi:

clean: 
	rm -f $(OBJS)

cleanall:
	rm -f $(OBJS) $(EXECS)
