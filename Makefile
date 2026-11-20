# ########################################################################################################
# Files                                                                                                  #
# ########################################################################################################
EMACS_DIR  := $(HOME)/.config/emacs
SOURCE_DIR := emacs

# Escanea automáticamente TODOS los archivos dentro de la carpeta emacs/
SOURCES    := $(wildcard $(SOURCE_DIR)/*)
# Genera las rutas de destino equivalentes en ~/.config/emacs/
TARGETS    := $(patsubst $(SOURCE_DIR)/%,$(EMACS_DIR)/%,$(SOURCES))

# ########################################################################################################
# Emacs                                                                                                  #
# ########################################################################################################
.ONESHELL:
.PHONY: emacs install

# El objetivo principal depende de que todos los archivos estén copiados
emacs: $(TARGETS)

# Regla genérica: empareja cada archivo de la carpeta origen con la carpeta destino
$(TARGETS): $(EMACS_DIR)/%: $(SOURCE_DIR)/%
	@mkdir -p $(dir $@)
	@cp -f $< $@
	@echo "$(notdir $<)"

install:
	@sudo aptitude install -y \
		cmake \
		clang \
		clang-tools \
		emacs-pgtk \
		fd-find \
		gcc \
		git \
		glslang-tools \
		libtool \
		make \
		nodejs \
		npm \
		ripgrep \
		shellcheck \
		sqlite3 \
		tidy
