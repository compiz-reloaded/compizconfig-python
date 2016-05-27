# Copyright (C) 1999, 2000, 2001, 2002, 2003  Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# AM_PATH_PYTHON_DEVEL([MIN-VERSION], [MAX-VERSION], [ACTION-IF-FOUND],
#  [ACTION-IF-NOT-FOUND])
# ---------------------------------------------------------------------------
# Wrapper over AM_PATH_PYTHON to populate PYTHON_INCLUDES and some other
# variables.
# It also can check for max Python version in order to avoid newer backwards
# incompatible APIs like Python 3.x is for Python 2.x.

AC_DEFUN([AM_PATH_PYTHON_DEVEL],
 [
  dnl If user didn't specify an interpreter, try to somewhat guess it before
  dnl invoking AM_PATH_PYTHON (which could otherwise find a too new one).
  if test -z "$PYTHON"; then
    for _python in python python3 python2; do
      m4_if([$2], [], [],
       [
        AC_MSG_CHECKING([whether $_python version is < $2])
        AM_PYTHON_CHECK_VERSION([$_python], [$2],
				[AC_MSG_RESULT([no])
				 _python_found=no],
				[AC_MSG_RESULT([yes])
				 _python_found=yes])
      ])
      test "x$_python_found" = xno && continue
      m4_if([$1], [], [],
       [
        AC_MSG_CHECKING([whether $_python version is >= $1])
        AM_PYTHON_CHECK_VERSION([$_python], [$1],
				[AC_MSG_RESULT([yes])
				 _python_found=yes],
				[AC_MSG_RESULT([no])
				 _python_found=no])
      ])
      if test "x$_python_found" = xyes; then
        AC_PATH_PROG(PYTHON, "$_python", [])
        AC_SUBST(PYTHON)
        break
      fi
    done
  fi
  AM_PATH_PYTHON([$1], [_python_found=yes], [_python_found=no])

  if test "x$_python_found" = xyes; then
    m4_if([$2], [], [],
     [
      AC_MSG_CHECKING([whether $PYTHON version is < $2])
      AM_PYTHON_CHECK_VERSION([$PYTHON], [$2],
			      [AC_MSG_RESULT([no])
			       _python_found=no],
			      [AC_MSG_RESULT([yes])])
    ])
  fi

  if test "x$_python_found" = xyes; then

    PYTHON_MAJOR_VER=`$PYTHON -c "import sys; print(sys.version_info.major)"`
    AC_SUBST(PYTHON_MAJOR_VER)
    if test "$PYTHON_MAJOR_VER" -gt 2; then
      PYTHON_SOINIT_PREFIX=PyInit_
    else
      PYTHON_SOINIT_PREFIX=init
    fi
    AC_SUBST(PYTHON_SOINIT_PREFIX)
    dnl Deduce PYTHON_INCLUDES.
    py_prefix=`$PYTHON -c "import sys; print(sys.prefix)"`
    py_exec_prefix=`$PYTHON -c "import sys; print(sys.exec_prefix)"`
    python_path=`$PYTHON -c "from distutils import sysconfig; print(sysconfig.get_python_inc(prefix='${py_prefix}'))" 2>/dev/null`
    python_arch_path=`$PYTHON -c "from distutils import sysconfig; print(sysconfig.get_python_inc(prefix='${py_exec_prefix}', plat_specific=1))" 2>/dev/null`
    if test -n "$python_path"; then
      PYTHON_INCLUDES="-I${python_path}"
    fi
    if test -n "$python_arch_path" && test "$python_path" != "$python_arch_path"; then
      PYTHON_INCLUDES="$PYTHON_INCLUDES -I${python_arch_path}"
    fi
    if test -z "$PYTHON_INCLUDES"; then
      PYTHON_INCLUDES="-I${py_prefix}/include/python${PYTHON_VERSION}"
      if test "$py_prefix" != "$py_exec_prefix"; then
        PYTHON_INCLUDES="$PYTHON_INCLUDES -I${py_exec_prefix}/include/python${PYTHON_VERSION}"
      fi
    fi
    AC_SUBST(PYTHON_INCLUDES)

    dnl Run any user-specified action.
    $3

  else
    dnl Run any user-specified action, or abort.
    m4_default([$4], [AC_MSG_ERROR([no suitable Python interpreter found])])
  fi
])
