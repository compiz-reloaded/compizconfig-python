ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

SUBDIRS = src

EXTRA_DIST =			  \
	COPYING			  \
	NEWS			  \
	README.md		  \
	autogen.sh		  \
	compizconfig-python.pc.in

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = compizconfig-python.pc

# Build ChangeLog from GIT  history
ChangeLog:
	$(AM_V_GEN) if test -d $(top_srcdir)/.git; then \
		GIT_DIR="$(top_srcdir)/.git" git log --stat > $@; \
	fi

dist: ChangeLog

.PHONY: ChangeLog
