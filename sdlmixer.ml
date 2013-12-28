(* OCamlSDL2_Mixer - An OCaml interface to the SDL2_mixer library
 Copyright (C) 2013 Florent Monnier
 
 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.
 
 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*)
(* Audio Mixer library for SDL2 *)

external init : unit -> unit
  = "caml_Mix_Init"

external quit : unit -> unit
  = "caml_Mix_Quit"

