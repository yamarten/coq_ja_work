cd coq
if [ -e config/coq_config.py ]; then
  :
else
  ./configure -local
fi
if [ -e doc/sphinx/index.rst ]; then
  :
else
  ln -f doc/sphinx/index.html.rst doc/sphinx/index.rst
fi
if [ -e doc/sphinx/build/doctrees ]; then
  rm -rf doc/sphinx/build/doctrees
else
  :
fi
make refman-gettext
cd doc/sphinx/_build/gettext/
for pot in *.pot; { msginit --no-translator -l ja -i $pot -o ../../../../../source/${pot%%.pot}.po; }
cd ../../../../..