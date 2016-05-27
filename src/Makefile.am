AM_CPPFLAGS=\
		 $(PYTHON_INCLUDES)\
		 @CCS_CFLAGS@

compizconfig.c: compizconfig.pyx
	'$(CYTHON)' -Wextra compizconfig.pyx $< -o $@

compizconfig_la_CFLAGS = -fno-strict-aliasing $(PYTHON_CFLAGS) $(AM_CFLAGS)
compizconfig_la_LDFLAGS = -module -avoid-version -fPIC -export-symbols-regex $(PYTHON_LDFLAGS) $(AM_LDFLAGS) $(py_soinitprefix)compizconfig -lX11
compizconfig_la_LIBADD = @CCS_LIBS@
compizconfig_la_SOURCES = compizconfig.c
compizconfigdir=$(pyexecdir)
compizconfig_LTLIBRARIES=compizconfig.la

EXTRA_DIST=compizconfig.pyx

clean-local:
	rm -f compizconfig.c
