#!/bin/bash
set -eux

pushd coq

rm -rf doc/sphinx/_build/doctrees

mkdir -p doc/sphinx/locales/ja/LC_MESSAGES/
cp -f ../target/*.po doc/sphinx/locales/ja/LC_MESSAGES/
make refman-html SPHINXOPTS='-D language="ja"'
mkdir -p ../html/refman
cp -rf doc/sphinx/_build/html/* ../html/refman

popd
