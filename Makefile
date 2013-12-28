# OCamlSDL2_Mixer - An OCaml interface to the SDL2_mixer library
# Copyright (C) 2013 Florent Monnier
#
# This software is provided "AS-IS", without any express or implied warranty.
# In no event will the authors be held liable for any damages arising from
# the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it freely.

OCAML = ocaml
OCAMLC = ocamlc
OCAMLOPT = ocamlopt
OCAMLDOC = ocamldoc
OCAMLDEP = ocamldep
OCAMLFIND = ocamlfind
OCAMLMKLIB = ocamlmklib
CC = gcc
OCAMLDIR = $(shell $(OCAMLC) -where)
DIRSEP = $(shell $(OCAML) dir_sep.ml)

PKG_CONFIG = pkg-config
CFLAGS = $(shell $(PKG_CONFIG) --cflags SDL2_mixer)
CFLAGS += -I$(OCAMLDIR)/sdl2/include/
LIBS_ = $(shell $(PKG_CONFIG) --libs SDL2_mixer)
LIBS = $(shell $(OCAML) prm.ml $(LIBS_))

BINDINGS_DIR = sdl2_mixer
EDITOR = vim

.PHONY: all lib opt
all: lib opt
lib: sdl2_mix.cma
opt: sdl2_mix.cmxa

%.cmi: %.mli
	$(OCAMLC) -c $<

%.cmo: %.ml
	$(OCAMLC) -c -I +sdl2 $<

%.cmx: %.ml
	$(OCAMLOPT) -c -I +sdl2 $<

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

