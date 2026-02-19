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
# Files                                                                                                   #
# ########################################################################################################
EMACS_DIR           = ~/.config/emacs
USER_INIT_CONF      = init.el
SYS_INIT_CONF       = ~/.config/emacs/init.el
USER_EARLY_CONF     = early-init.el
SYS_EARLY_CONF      = ~/.config/emacs/early-init.el

# ########################################################################################################
# Emacs                                                                                                  #
# ########################################################################################################
.ONESHELL :
.PHONY : init early install

emacs : init early

init : $(SYS_INIT_CONF)

$(SYS_INIT_CONF) : $(USER_INIT_CONF)
	@$(MK) $(EMACS_DIR)
	@$(CP) $(USER_INIT_CONF) $(SYS_INIT_CONF)
	@$(OK) "Init"

$(USER_INIT_CONF) :

early : $(SYS_EARLY_CONF)

$(SYS_EARLY_CONF) : $(USER_EARLY_CONF)
	@$(MK) $(EMACS_DIR)
	@$(CP) $(USER_EARLY_CONF) $(SYS_EARLY_CONF)
	@$(OK) "Packages"

$(USER_EARLY_CONF) :

install :
	sudo dnf install \
		emacs-pgtk git ripgrep fd-find ShellCheck tidy \
		sqlite libtool cmake gcc clang make nodejs \
		nodejs-npm glslang clang clang-tools-extra
	@systemctl --user enable --now emacs.service
	@cp -f emacs.desktop ~/.local/share/applications
	@$(OK) "Install"
