cd coq
if [ -e doc/sphinx/build/doctrees ]; then
  rm -rf doc/sphinx/build/doctrees
else
  :
fi
if [ -e doc/sphinx/locales/ja/LC_MESSAGES/ ]; then
  mkdir -p doc/sphinx/locales/ja/LC_MESSAGES/
else
  :
fi
cp -f ../target/*.po doc/sphinx/locales/ja/LC_MESSAGES/
make refman-html SPHINXOPTS='-D language="ja"'
cp -rf doc/sphinx/_build/html/* ../html/refman
cd ..