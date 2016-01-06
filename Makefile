PROJECT             = lone-ranger
PROJECT_DESCRIPTION = Cowboy utilities for LFE.
PROJECT_VERSION     = 0.0.1

DEPS        = lfe cowboy
BUILD_DEPS  = lfe.mk
DEP_PLUGINS = lfe.mk
dep_lfe.mk  = git https://github.com/ninenines/lfe.mk master
dep_cowboy  = git https://github.com/ninenines/cowboy master

include erlang.mk
