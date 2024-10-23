PLATFORM ?= PLATFORM_DESKTOP
BUILD_MODE ?= RELEASE
RAYLIB_DIR = /usr/local  # Adjust this to your raylib installation directory
INCLUDE_DIR = -I ./ -I /usr/local/include
LIBRARY_DIR = -L /usr/local/lib
DEFINES = -D _DEFAULT_SOURCE -D RAYLIB_BUILD_MODE=$(BUILD_MODE) -D $(PLATFORM)

ifeq ($(PLATFORM),PLATFORM_DESKTOP)
    CC = g++
    EXT = 
    ifeq ($(BUILD_MODE),RELEASE)
        CFLAGS ?= $(DEFINES) -ffast-math -march=native -D NDEBUG -O3 $(INCLUDE_DIR) $(LIBRARY_DIR) 
	else
        CFLAGS ?= $(DEFINES) -g $(INCLUDE_DIR) $(LIBRARY_DIR) 
	endif
    LIBS = -lraylib -lGL -lm -lpthread -ldl -lrt -lX11  # Link necessary libraries for raylib
endif

SOURCE = $(wildcard *.cpp)
HEADER = $(wildcard *.h)

.PHONY: all

all: controller

controller: $(SOURCE) $(HEADER)
	$(CC) -o $@ $(SOURCE) $(CFLAGS) $(LIBS) 

clean:
	rm -f controller
