# slock - simple screen locker
# See LICENSE file for copyright and license details.

include config.mk

SRC = slock.c ${COMPATSRC}
OBJ = ${SRC:.c=.o}

all: slock

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk util.h

slock: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f slock ${OBJ} slock-${VERSION}.tar.gz

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	install slock ${DESTDIR}${PREFIX}/bin
	chmod u+s ${DESTDIR}${PREFIX}/bin/slock
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" <slock.1 >${DESTDIR}${MANPREFIX}/man1/slock.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/slock.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/slock
	rm -f ${DESTDIR}${MANPREFIX}/man1/slock.1

.PHONY: all clean install uninstall
