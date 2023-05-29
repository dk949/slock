# slock version

DATE         = $(shell git log -1 --format='%cd' --date=format:'%F')
DATE_TIME    = $(DATE) 00:00
COMMIT_COUNT = $(shell git rev-list --count HEAD --since="$(DATE_TIME)")
VERSION      = 1.4.$(shell date -d "$(DATE)" +'%Y%m%d')_$(COMMIT_COUNT)

# Customize below to fit your system

# paths
DESTDIR   ?=
PREFIX    ?= /usr/local
MANPREFIX = $(PREFIX)/share/man

REQ_LIBS = x11 xext xrandr libcrypt

# includes and libs
LIBFLAGS = `pkg-config $(REQ_LIBS) --cflags`
LIBS     = `pkg-config $(REQ_LIBS) --libs`

# flags
CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_DEFAULT_SOURCE -DHAVE_SHADOW_H
CFLAGS = -std=c99 -pedantic -Wall -Og -g $(LIBFLAGS) $(CPPFLAGS)
LDFLAGS = $(LIBS)
COMPATSRC = explicit_bzero.c

# On OpenBSD and Darwin remove -lcrypt from LIBS
#LIBS = -L/usr/lib -lc -L${X11LIB} -lX11 -lXext -lXrandr
# On *BSD remove -DHAVE_SHADOW_H from CPPFLAGS
# On NetBSD add -D_NETBSD_SOURCE to CPPFLAGS
#CPPFLAGS = -DVERSION=\"${VERSION}\" -D_BSD_SOURCE -D_NETBSD_SOURCE
# On OpenBSD set COMPATSRC to empty
#COMPATSRC =

# compiler and linker
CC = cc
