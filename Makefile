SRC_LOC := coq/doc/sphinx
POT_LOC := $(SRC_LOC)/_build/gettext
OBJ_LOC := source

# sphinx直下で翻訳対象にならないファイル
SRC_EXCLUDE_PATS := \
	$(SRC_LOC)/README%.rst \
	$(SRC_LOC)/refman-preamble.rst \
	$(SRC_LOC)/introduction.rst \
	$(SRC_LOC)/%.html.rst \
	$(SRC_LOC)/%.latex.rst

# *.html.rstの「.html」を省いたもの サブディレクトリには含まれていないと仮定
SRC_HTML := $(subst .html.rst,.rst,$(wildcard $(SRC_LOC)/*.html.rst))
# sphinx直下
SRC_ROW := $(wildcard $(SRC_LOC)/*.rst)
SRC_TOP := $(sort $(filter-out $(SRC_EXCLUDE_PATS),$(SRC_ROW)) $(SRC_HTML))
# サブディレクトリ
SRC_DEEP := $(wildcard $(SRC_LOC)/*/*.rst)
SRC_DIR := $(sort $(dir $(SRC_DEEP)))
# rstファイル全体
SRC_ALL := $(SRC_TOP) $(SRC_DEEP)

POT_TOP := $(SRC_TOP:$(SRC_LOC)/%.rst=$(POT_LOC)/%.pot)
POT_DIR := $(SRC_DIR:$(SRC_LOC)/%/=$(POT_LOC)/%.pot)
POT_ALL := $(POT_TOP) $(POT_DIR)

OBJ_ALL := $(POT_ALL:$(POT_LOC)/%.pot=$(OBJ_LOC)/%.po)

.PHONY: all

all: $(OBJ_ALL)

$(OBJ_LOC)/%.po: $(POT_LOC)/%.pot
	msginit --no-translator -l ja -i $^ -o $@

$(POT_ALL): $(SRC_ALL)
	rm -rf $(SRC_LOC)/doctrees
	cd coq && make refman-gettext

$(SRC_HTML): $(subst .rst,.html.rst,$@)
	ln -f $^ $@