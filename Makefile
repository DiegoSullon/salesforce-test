# Terminal colors
ifneq (,$(findstring xterm,${TERM}))
    RED     := $(shell tput -Txterm setaf 1)
    YELLOW  := $(shell tput -Txterm setaf 3)
    MAGENTA := $(shell tput -Txterm setaf 5)
    CYAN    := $(shell tput -Txterm setaf 6)
    RESET   := $(shell tput -Txterm sgr0)
    WHITE   := $(shell tput -Txterm setaf 7)
else
    RED     := ""
    YELLOW  := ""
    MAGENTA := ""
    CYAN    := ""
    RESET   := ""
    WHITE   := ""
endif

help: ## Shows help
	@make -s __logotype
	@echo '${YELLOW}************************${RESET}'
	@echo '${YELLOW}* ${CYAN}Usage: ${RESET}make [${MAGENTA}target${RESET}]${YELLOW} *'
	@echo '${YELLOW}************************${RESET}'
	@echo '${YELLOW}* ${CYAN}Targets: ${YELLOW}            *'
	@echo '${YELLOW}************************${RESET}'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | sort | column -t -c 2 -s ':#'

build: ## Builds SFRA, Kiwoko and Returns
	@make -s __logotype
	@make -s __build.sfra
	@make -s __build.kw
	@make -s __build.returns

build.sfra: ## Builds SFRA
	@make -s __logotype
	@make -s __build.sfra

__build.test:
	npm --prefix ./page-designer run compile:scss
	npm --prefix ./page-designer run compile:js
	npm --prefix ./page-designer run compile:scss
	npm --prefix ./page-designer run compile:fonts

build.kw: ## Builds Kiwoko
	@make -s __logotype
	@make -s __build.kw

build.returns: ## Builds Returns
	@make -s __logotype
	@make -s __build.returns
	
build.superzoo: ## Builds SuperZoo
	@make -s __logotype
	@make -s __build.superzoo

tests: ## Run All tests
	@make -s __logotype
	@make -s __tests.kw
	@make -s __tests.sfra

tests.kw: ## Run Kiwoko tests
	@make -s __logotype
	@make -s __tests.kw

tests.kw.cover: ## Run Kiwoko coverage tests
	@make -s __logotype
	@make -s __tests.kw.cover

# Internals
__build.sfra:
	npm --prefix ./storefront-reference-architecture run build

__build.kw:
	npm --prefix ./kiwoko_cartridges run compile:js
	npm --prefix ./kiwoko_cartridges run compile:scss

__build.superzoo:
	npm --prefix ./superzoo_cartridges run compile:js
	npm --prefix ./superzoo_cartridges run compile:scss
	npm --prefix ./superzoo_cartridges run compile:fonts
	npm --prefix ./chile_cartridges run compile:js
	npm --prefix ./chile_cartridges run compile:scss

__build.returns:
	npm --prefix ./returns_cartridges run compile:js
	npm --prefix ./returns_cartridges run compile:scss

__tests.kw:
	npm --prefix ./kiwoko_cartridges run test

__tests.sfra:
	npm --prefix ./storefront-reference-architecture run test

__tests.kw.cover:
	npm --prefix ./kiwoko_cartridges run cover

__logotype:
	@clear
	@echo '${RED} _____       _                  ${RESET}${WHITE}______        _   ${RESET}'
	@echo '${RED}|_   _|     | |                 ${RESET}${WHITE}| ___ \      | |  ${RESET}'
	@echo '${RED}  | |   ___ | | __  __ _  _   _ ${RESET}${WHITE}| |_/ /  ___ | |_ ${RESET}'
	@echo '${RED}  | |  / __|| |/ / / _` || | | |${RESET}${WHITE}|  __/  / _ \| __|${RESET}'
	@echo '${RED} _| |_ \__ \|   < | (_| || |_| |${RESET}${WHITE}| |    |  __/| |_ ${RESET}'
	@echo '${RED} \___/ |___/|_|\_\ \__,_| \__, |${RESET}${WHITE}\_|     \___| \__|${RESET}'
	@echo '${RED}                           __/ |${RESET}${WHITE}                  ${RESET}'
	@echo '${RED}                          |___/ ${RESET}${WHITE} all about petcare${RESET}'
