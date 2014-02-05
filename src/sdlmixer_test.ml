#load "sdl2_mix.cma"

let () =
  Sdlmixer.init [`MP3];
  Sdlmixer.quit ();
;;

