/* OCamlSDL2_Mixer - An OCaml interface to the SDL2_mixer library
 Copyright (C) 2013 Florent Monnier
 
 This software is provided "AS-IS", without any express or implied warranty.
 In no event will the authors be held liable for any damages arising from
 the use of this software.
 
 Permission is granted to anyone to use this software for any purpose,
 including commercial applications, and to alter it and redistribute it freely.
*/
#define CAML_NAME_SPACE
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>

#include <SDL_mixer.h>
#include <sdlaudio_stub.h>
#include "sdlmixer_stub.h"

/* init */

static inline Uint32
sdlmixinit_val(value v)
{
    if (v == caml_hash_variant("FLAC"))       return MIX_INIT_FLAC;
    if (v == caml_hash_variant("MOD"))        return MIX_INIT_MOD;
    if (v == caml_hash_variant("MODPLUG"))    return MIX_INIT_MODPLUG;
    if (v == caml_hash_variant("MP3"))        return MIX_INIT_MP3;
    if (v == caml_hash_variant("OGG"))        return MIX_INIT_OGG;
    if (v == caml_hash_variant("FLUIDSYNTH")) return MIX_INIT_FLUIDSYNTH;
    return 0x00000000;
}

CAMLprim value
caml_Mix_Init(value flags_list)
{
    Uint32 flags = 0;
    while (flags_list != Val_emptylist) {
        value head = Field(flags_list, 0);
        flags |= sdlmixinit_val(head);
        flags_list = Field(flags_list, 1);
    }
    Uint32 ret_flags = Mix_Init(flags);
    if (ret_flags != flags) caml_failwith(Mix_GetError());

    return Val_unit;
}

CAMLprim value
caml_Mix_Quit(value unit)
{
    Mix_Quit();

    return Val_unit;
}

CAMLprim value
caml_Mix_Open_Audio(value frequency, value format, value channels, value chunksize) 
{
    int ret = Mix_OpenAudio(Int_val(frequency),
                            SDL_AudioFormat_val(format),
                            Int_val(channels),
                            Int_val(chunksize));
    if (-1 == ret) caml_failwith(Mix_GetError());

    return Val_unit;
}

/* music */

CAMLprim value
caml_Mix_Load_Music(value filename)
{
    Mix_Music* music = Mix_LoadMUS(String_val(filename));
    if (NULL == music) caml_failwith(Mix_GetError());

    return Val_SDLMIXER_Music(music);
}

CAMLprim value
caml_Mix_Free_Music(value music)
{
    Mix_FreeMusic(SDLMIXER_Music_val(music));

    return Val_unit;
}

CAMLprim value
caml_Mix_Play_Music(value music, value loops)
{
    int ret = Mix_PlayMusic(SDLMIXER_Music_val(music), Int_val(loops));
    if (-1 == ret) caml_failwith(Mix_GetError());

    return Val_unit;
}

/* defines getters */

CAMLprim value
caml_Mix_Get_Major_Version(value unit)
{
    return Val_int(SDL_MIXER_MAJOR_VERSION);
}

CAMLprim value
caml_Mix_Get_Minor_Version(value unit)
{
    return Val_int(SDL_MIXER_MINOR_VERSION);
}

CAMLprim value
caml_Mix_Get_Patchlevel(value unit)
{
    return Val_int(SDL_MIXER_PATCHLEVEL);
}

CAMLprim value
caml_Mix_Get_Channels(value unit)
{
    return Val_int(MIX_CHANNELS);
}

CAMLprim value
caml_Mix_Get_Default_Frequency(value unit)
{
    return Val_int(MIX_DEFAULT_FREQUENCY);
}

CAMLprim value
caml_Mix_Get_Default_Format(value unit)
{
    return Val_SDL_AudioFormat(MIX_DEFAULT_FORMAT);
}

CAMLprim value
caml_Mix_Get_Default_Channels(value unit)
{
    return Val_int(MIX_DEFAULT_CHANNELS);
}

CAMLprim value
caml_Mix_Get_Max_Volume(value unit)
{
    return Val_int(MIX_MAX_VOLUME);
}

CAMLprim value
caml_Mix_Get_Channel_Post(value unit)
{
    return Val_int(MIX_CHANNEL_POST);
}

CAMLprim value
caml_Mix_Get_Effectsmaxspeed(value unit)
{
    return Val_int(MIX_EFFECTSMAXSPEED);
}

/* vim: set ts=4 sw=4 et: */
/* Local Variables: */
/* c-basic-offset:4; tab-width:4; indent-tabs-mode:nil; */
/* End: */