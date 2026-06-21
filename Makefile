# ========= Configuration =========
LATEX 		:= lualatex

DIR 		:= 01

PARENT		= $(realpath tex/$(DIR))
MAIN		= $(PARENT)/main
BUILD		= $(PARENT)/build
PDFDIR		= $(PARENT)/pdf
ARGS		?= 

# ==================================
_ARGS		:= \
			-$(LATEX) \
			-outdir=$(BUILD) \
			-interaction=nonstopmode \
			-synctex=1 \
			$(ARGS)

VERBOSE		:= 1

RED 		:= \033[1;91m
GREEN 		:= \033[1;92m
YELLOW 		:= \033[1;93m
BLUE		:= \033[1;94m
MAGENTA		:= \033[1;95m
CYAN		:= \033[1;96m
RESET 		:= \033[0m

ifeq ($(VERBOSE), 1)
	_VERBOSE = 
else
	_VERBOSE = @
endif

.PHONY: debug help compile full remove clear clean
# ========= Help Messages & Debug =========
ARG_MSG				= $(BLUE)LATEX=<compiler> PARENT=<root_path> MAIN=<filename> BUILD=<build_path> PDFDIR=<pdf_path>$(RESET)
DEFAULT_ARG_MSG		= $(YELLOW)(default LATEX=lualatex PARENT=01, MAIN=main, BUILD=build, PDFDIR=pdf)$(RESET)

DEFAULT_CMD1_MSG	= \`$(MAGENTA)make compile $(DEFAULT_ARG_MSG)\`
DEFAULT_CMD2_MSG	= \`$(MAGENTA)make full $(DEFAULT_ARG_MSG)\`

CMD_FORMAT1    		= $(MAGENTA)\`make compile $(ARG_MSG)\`$(RESET)
CMD_FORMAT2    		= $(MAGENTA)\`make full $(ARG_MSG)\`$(RESET)

NOTE_MSG      		= The main file \`main.tex\` will be compiled and saved as \`build/main.pdf\`.
HELP_MSG      		= \
	"$(GREEN)Command format:$(RESET)\n \
	\t$(CMD_FORMAT1)\n \
	\t$(CMD_FORMAT2)\n \
	\t$(DEFAULT_CMD1_MSG)\n \
	\t$(DEFAULT_CMD2_MSG)\n \
	$(GREEN)Note$(RESET): $(NOTE_MSG)\n \
	$(GREEN)Available commands:$(RESET)"

help: ### Show this help message
	@echo $(HELP_MSG)
	@awk -F ':.*###' '$$0 ~ FS {printf "$(GREEN)%15s$(RESET)%s\n", $$1 ":", $$2}' \
		$(MAKEFILE_LIST) | grep -v '@awk' | sort

debug: 
	@echo "PARENT: $(PARENT)"
	@echo "MAIN:   $(MAIN)"
	@echo "BUILD:  $(BUILD)"
	@echo "PDFDIR: $(PDFDIR)"


# ========= Build Targets =========
compile: ### Compile the LaTeX document into `BUILD`
	$(_VERBOSE)latexmk $(MAIN) $(_ARGS)

full: compile ### Compile and copy final PDF to `PDFDIR`
	@echo "$(GREEN)Copying file PDF file \`$(CYAN)$(MAIN).pdf$(GREEN)\` to \`$(CYAN)$(PDFDIR)$(GREEN)\`$(RESET)"
	$(_VERBOSE)mkdir -p $(PDFDIR)
	$(_VERBOSE)cp $(BUILD)/$(MAIN).pdf $(PDFDIR)/$(MAIN).pdf

remove: ### Prompt before deleting `BUILD`
	@echo "$(RED)Are you sure you want to delete the directory $(YELLOW)'$(BUILD)'$(RED)? (y/N)$(RESET)"
	@read -p "Type y to confirm: " confirm; \
	if [ "$$confirm" = "y" ]; then \
		echo "$(RED)Deleting $(YELLOW)$(BUILD)$(RESET)"; \
		rm -rf $(BUILD); \
	else \
		echo "$(GREEN)Deletion cancelled.$(RESET)"; \
	fi

clear: ### Remove intermediate files in `BUILD` using `latexmk -c`
	$(_VERBOSE)latexmk -c -outdir=$(BUILD) $(MAIN).tex

clean: clear ### Alias for `clear` (remove intermediate LaTeX build files)
