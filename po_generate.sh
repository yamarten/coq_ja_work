#!/bin/bash
set -eux

pushd coq

if [ ! -e config/coq_config.py ]; then
  ./configure -local
fi

if [ ! -e doc/sphinx/index.rst ]; then
  ln -f doc/sphinx/index.html.rst doc/sphinx/index.rst
fi

rm -rf doc/sphinx/_build/doctrees

make refman-gettext

pushd doc/sphinx/_build/gettext/
for pot in *.pot; do
  msginit --no-translator -l ja -i $pot -o ../../../../../source/${pot%%.pot}.po
done
popd

popd

