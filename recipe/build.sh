#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .
set -eo pipefail

# fix perl shebang
sed -i.bak '1 s|^.*$|#!/usr/bin/env perl|g' $SRC_DIR/tests/t*.pl

./configure --prefix=${PREFIX}
make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  make check
fi
make install
