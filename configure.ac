AC_PREREQ(2.57)
AC_INIT([compizconfig-python], [0.8.12.1], [livinglatexkali@gmail.com])

AM_INIT_AUTOMAKE([1.9 foreign dist-xz no-dist-gzip check-news])
AC_CONFIG_HEADER([config.h])
AC_CONFIG_MACRO_DIR([m4])
AM_MAINTAINER_MODE

AC_ISC_POSIX
AC_PROG_CC
AC_PROG_CPP
LT_INIT
AC_HEADER_STDC

CCS_REQUIRES="\
libcompizconfig >= 0.6.99 \
glib-2.0 >= 2.6 "

PKG_CHECK_MODULES(CCS,$CCS_REQUIRES)

AC_SUBST(CCS_REQUIRES)

dnl PYTHON SPECIFIC

AM_PATH_PYTHON_DEVEL([2.7],[4.0])

AC_ARG_WITH(cython, [  --with-cython=PATH ],
		    [with_cython="$withval"],
		    [with_cython="cython"])
AC_SUBST(cython)

AC_CHECK_PROGS(CYTHON, "$with_cython")
if test -n "$CYTHON"; then
  CYTHON="`which "$CYTHON"`"
else
  AC_MSG_ERROR([Couldn't find Cython])
fi

AC_CONFIG_FILES([
  compizconfig-python.pc
  Makefile
  src/Makefile
])

AC_OUTPUT
