(* OCamlSDL2_Mixer - An OCaml interface to the SDL2_mixer library
 Copyright (C) 2013 Florent Monnier
 
 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.
 
 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*)
(* Audio Mixer library for SDL2 *)


type initflags = [
| `FLAC
| `MOD
| `MODPLUG
| `MP3
| `OGG
| `FLUIDSYNTH
]

type music

(* init *)

external init : initflags list -> unit
  = "caml_SDL_Mix_Init"

external quit : unit -> unit
  = "caml_SDL_Mix_Quit"

external open_audio : int -> Sdlaudio.format -> int -> int -> unit
  = "caml_SDL_Mix_Open_Audio"

(* music *)

external load_music : string -> music
  = "caml_SDL_Mix_Load_Music"

external free_music : music -> unit
  = "caml_SDL_Mix_Free_Music"

external play_music : music -> int -> unit
  = "caml_SDL_Mix_Play_Music"

(* defines getters *)

external get_major_version : unit -> int
  = "caml_SDL_Mix_Get_Major_Version"

external get_minor_version : unit -> int
  = "caml_SDL_Mix_Get_Minor_Version"

external get_patchlevel : unit -> int
  = "caml_SDL_Mix_Get_Patchlevel"

external get_channels : unit -> int
  = "caml_SDL_Mix_Get_Channels"

external get_default_frequency : unit -> int
  = "caml_SDL_Mix_Get_Default_Frequency"

external get_default_format : unit -> Sdlaudio.format
  = "caml_SDL_Mix_Get_Default_Format"

external get_default_channels : unit -> int
  = "caml_SDL_Mix_Get_Default_Channels"

external get_max_volume : unit -> int
  = "caml_SDL_Mix_Get_Max_Volume"

external get_channel_post : unit -> int
  = "caml_SDL_Mix_Get_Channel_Post"

external get_effectsmaxspeed : unit -> int
  = "caml_SDL_Mix_Get_Effectsmaxspeed"
