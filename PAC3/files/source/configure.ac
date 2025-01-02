# Copyright (C) 2024 Robert Buj <rbuj@uoc.edu>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.

AC_INIT([M1.209-pac3],[0.1],[rbuj@uoc.edu])
AC_COPYRIGHT([Copyright (C) 2024 Robert Buj])
AM_INIT_AUTOMAKE([foreign])
AM_SILENT_RULES([yes])
AC_PROG_CC([mpicc])
AC_PROG_CC_STDC
AC_CONFIG_FILES([
Makefile
src/Makefile
])
AC_OUTPUT

echo "
Configure summary:

      ${PACKAGE_STRING}
      `echo $PACKAGE_STRING | sed "s/./=/g"`
      prefix:                     ${prefix}
      compiler:                   ${CC}
      cflags:                     ${CFLAGS}
"
