AM_CPPFLAGS=\
		 $(PYTHON_INCLUDES)\
		 @CCS_CFLAGS@

compizconfig.c: compizconfig.pyx
	'$(CYTHON)' -$(PYTHON_MAJOR_VER) -Wextra $< -o $@

compizconfig_la_CFLAGS = -fno-strict-aliasing $(PYTHON_CFLAGS) $(AM_CFLAGS)
compizconfig_la_LDFLAGS = -module -avoid-version -fPIC -export-symbols-regex $(PYTHON_LDFLAGS) $(AM_LDFLAGS) $(PYTHON_SOINIT_PREFIX)compizconfig
compizconfig_la_LIBADD = @CCS_LIBS@
nodist_compizconfig_la_SOURCES = compizconfig.c
compizconfigdir=$(pyexecdir)
compizconfig_LTLIBRARIES=compizconfig.la

EXTRA_DIST=compizconfig.pyx

clean-local:
	rm -f compizconfig.c
