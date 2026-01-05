# ########################################################################################################
# Colores                                                                                                #
# ########################################################################################################
GREEN               = \033[1;32m
BLUE                = \033[1;34m
YELLOW              = \033[1;33m
RED                 = \033[1;31m
CYAN                = \033[1;36m
RESET               = \033[1;0m

# ########################################################################################################
# Variables                                                                                              #
# ########################################################################################################
SU                  = sudo
CP                  = cp -f
RM                  = rm -rf
MK                  = mkdir -p
ECHO                = echo -e
OK                  = $(ECHO) "  [$(GREEN)OK$(RESET)]"

# ########################################################################################################
# Doom                                                                                                   #
# ########################################################################################################
DOOM_REPO           = https://github.com/doomemacs/doomemacs
EMACS_DIR           = ~/.config/emacs
DOOM_DIR            = ~/.config/doom
USER_CONFIG         = doom/config.el
SYS_CONFIG          = ~/.config/doom/config.el
USER_INIT           = doom/init.el
SYS_INIT            = ~/.config/doom/init.el
USER_PACKAGES       = doom/packages.el
SYS_PACKAGES        = ~/.config/doom/packages.el

# ########################################################################################################
# Emacs                                                                                                  #
# ########################################################################################################
.ONESHELL :
.PHONY : doom config init packages install sync clean

doom : config init packages

config : $(SYS_CONFIG)

$(SYS_CONFIG) : $(USER_CONFIG)
	@$(MK) $(DOOM_DIR)
	@$(CP) $(USER_CONFIG) $(SYS_CONFIG)
	@$(OK) "Config"

$(USER_CONFIG) :

init : $(SYS_INIT)

$(SYS_INIT) : $(USER_INIT)
	@$(MK) $(DOOM_DIR)
	@$(CP) $(USER_INIT) $(SYS_INIT)
	@$(OK) "Init"

$(USER_INIT) :

packages : $(SYS_PACKAGES)

$(SYS_PACKAGES) : $(USER_PACKAGES)
	@$(MK) $(DOOM_DIR)
	@$(CP) $(USER_PACKAGES) $(SYS_PACKAGES)
	@$(OK) "Packages"

$(USER_PACKAGES) :

install :
	@if [ ! -d $(EMACS_DIR) ]; then
		sudo pacman -S \
			emacs-wayland git ripgrep fd shellcheck tidy \
			sqlite libtool cmake gcc clang make nodejs \
			npm glslang
		@git clone --depth 1 $(DOOM_REPO) $(EMACS_DIR)
		@$(EMACS_DIR)/bin/doom install
		@$(EMACS_DIR)/bin/doom doctor
	fi
	@$(OK) "Install"

sync :
	@$(EMACS_DIR)/bin/doom sync
	@$(OK) "Sync"

clean :
	@$(RM) $(EMACS_DIR) $(DOOM_DIR)
	@$(OK) "Clean"

