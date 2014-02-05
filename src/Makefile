# OCamlSDL2_Mixer - An OCaml interface to the SDL2_mixer library
# Copyright (C) 2013 Florent Monnier
#
# This software is provided "AS-IS", without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from
# the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it freely.

OCAMLFIND := ocamlfind
USEFIND := $(shell which $(OCAMLFIND) 2>/dev/null)

ifdef USEFIND
OCAMLC = $(OCAMLFIND) ocamlc
OCAMLOPT = $(OCAMLFIND) ocamlopt
OCSDLINC = -package sdl2
else
OCAMLC = ocamlc
OCAMLOPT = ocamlopt
OCSDLINC = -I +sdl2
endif

OCAMLMKLIB = ocamlmklib
OCAMLDOC = ocamldoc
OCAMLDEP = ocamldep
OCAML = ocaml
CC = gcc
OCAMLDIR = $(shell $(OCAMLC) -where)
DIRSEP = $(shell $(OCAML) dir_sep.ml)
OCSDLDIR = $(OCAMLDIR)/sdl2
OCSDLINCDIR = $(OCSDLDIR)/include/
SDLINCDIR = /usr/include/SDL2
DOC_DIR = doc
MKDIR = mkdir -p
RMDIR = rmdir

BINDINGS_DIR := sdl2_mix
PREFIX := 
DESTDIR := $(PREFIX)$(DIRSEP)$(OCAMLDIR)$(DIRSEP)$(BINDINGS_DIR)
UNINSTALL_DIR := rm -Rf
INSTALL_DIR := mkdir -p
INSTALL_FILES := cp -f

PKG_CONFIG = pkg-config
CFLAGS = $(shell $(PKG_CONFIG) --cflags SDL2_mixer)
CFLAGS += -I$(OCSDLINCDIR)
LIBS_ = $(shell $(PKG_CONFIG) --libs SDL2_mixer)
LIBS = $(shell $(OCAML) prm.ml $(LIBS_))

EDITOR = vim

.PHONY: all lib opt
all: lib opt
lib: sdl2_mix.cma
opt: sdl2_mix.cmxa

%.cmi: %.mli
	$(OCAMLC) -c $(OCSDLINC) $<

%.cmo: %.ml
	$(OCAMLC) -c $(OCSDLINC) $<

%.cmx: %.ml
	$(OCAMLOPT) -c $(OCSDLINC) $<

sdlmixer_stub.o: sdlmixer_stub.c
	$(OCAMLC) -ccopt "-static $(CFLAGS) -g -O " $<


sdl2_mix.cma: sdlmixer.cmo libsdl2mixer_stubs.a
	$(OCAMLMKLIB) -o sdl2_mix -oc sdl2mixer_stubs sdlmixer.cmo $(LIBS)

sdl2_mix.cmxa: sdlmixer.cmx libsdl2mixer_stubs.a
	$(OCAMLMKLIB) -o sdl2_mix -oc sdl2mixer_stubs sdlmixer.cmx $(LIBS)

libsdl2mixer_stubs.a: sdlmixer_stub.o
	$(OCAMLMKLIB) -o sdl2_mix -oc sdl2mixer_stubs sdlmixer_stub.o $(LIBS)

.PHONY: edit
edit:
	$(EDITOR) sdlmixer.ml sdlmixer_stub.c

.PHONY: clean
clean:
	$(RM) *.[oas] *.cm[ioxta] *.cmx[as] *.so *.dll *.opt *.exe


# Installation

.PHONY: install uninstall reinstall

install: META sdl2_mix.cma

ifdef USEFIND
install:
	$(OCAMLFIND) install $(BINDINGS_DIR) META \
	  *.cm[aix] *.cmx[as] sdl2*.a *sdl2*_stubs.*
uninstall:
	$(OCAMLFIND) remove $(BINDINGS_DIR)
else
install:
	$(INSTALL_DIR) $(DESTDIR)
	$(INSTALL_FILES) \
	  *.cm[aix] *.cmx[as] sdl2*.a *sdl2*_stubs.* \
	  $(DESTDIR)
uninstall:
	$(UNINSTALL_DIR) $(DESTDIR)
endif

reinstall:
	$(MAKE) clean
	$(MAKE) all
	$(MAKE) uninstall
	$(MAKE) install
