# PicoVJ

A functional VJ framework for PICO8! It is very scoped and usable with a single controller.

# Instructions 

You can try the commands in the main menu, to get the feel.

- Beat manager
LEFT - A single tap resets BPM / Beat num. A next tap in the 4th next beat, will store the calculated BPM.
X + UP / DOWN - adjust BPM speed.
X + LEFT / RIGHT -  fine tune BPM sync.

- Scene manager
Z + UP - set a random scene.
Z + LEFT / RIGHT - previous / next scene (cycled).

- FX manager
UP / DOWN - increase / decrease FXRAGE from 0 to 1.
RIGHT - cycle FXFLASH value from 0 to 5.

FXRAGE is the hype value of the application, and how it behaves depends on each effect implementation. An effect at FXRAGE = 0 would be simple, slow, but the same effect at FXRAGE = 1 would be much faster and frenzy.

FXFLASH will define when the BEATFLASH is set.

- Constantes

VJ_TIME - Real run time of application (float, in seconds).
VJ_BPM - Current BPM.
VJ_BEAT - Gets set to 1 on every beat, gets to 0 in a few frames.
VJ_BEATFLASH - Same as VJ_BEAT, but it only gets set to 1 depending on FXFLASH value. If FXFLASH = 1, VJ_BEATFLASH will get to 1 only on the first beat (of 4). If FXFLASH = 3, it will get to 1 on the 2nd and 4th beats. There's a few variations.
VJ_BEATTIME - Run time of application normalized to beats. It will go from 0 to 1 in the span of time it takes a beat (so it will change dynamically as you update BPM). It can be used to make your loops sync with the beat easy.
VJ_BEATTIME4 - Same as VJ_BEATTIME, but will get from 0 to 1 in the spanof time it takes 4 beats.
VJ_BEATLEN - The amount of time it takes for a beat to happen (it's the inverse of VJ_BEATTIME).
VJ_BEATLEN4 - Same as VJ_BEATLEN3, but the amount of time it takes for 4 beats ot happen.

- Helpers
A few helpers are available, including a lerp function, a common palette for palette effects, and so.

- Expand

If you want to create your own effects (encouraged if you plan to doyour own VJ gig!), you can
Make a new draw function for your effect, and make sure it runs at 60 fps
Add the name of the draw function to VJ_LOOPS array.

- ToDo

I want to add a super simply TV Overlay effect, were users could write using the keyboard
Would be great to add a second set of scenes for overlay, but that might complicate user input and haven't thought much about that.
