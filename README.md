# PicoVJ

A functional VJ framework for PICO8! It is very scoped and usable with a single controller.

# Instructions 

You can try the commands in the main menu, to get the feel.

- Beat manager

LEFT - A single tap resets BPM / Beat num. A next tap in the 4th next beat, will store the calculated BPM.<br>
X + UP / DOWN - adjust BPM speed.<br>
X + LEFT / RIGHT -  fine tune BPM sync.<br>

- Scene manager

Z + UP - set a random scene.<br>
Z + LEFT / RIGHT - previous / next scene (cycled).<br>

- FX manager<br>
UP / DOWN - increase / decrease FXRAGE from 0 to 1.<br>
RIGHT - cycle FXFLASH value from 0 to 5.<br>

FXRAGE is the hype value of the application, and how it behaves depends on each effect implementation. An effect at FXRAGE = 0 would be simple, slow, but the same effect at FXRAGE = 1 would be much faster and frenzy.

FXFLASH will define when the BEATFLASH is set.

- VJ Vars

VJ_TIME - Real run time of application (float, in seconds).<br>
VJ_BPM - Current BPM.<br>
VJ_BEAT - Gets set to 1 on every beat, gets to 0 in a few frames.<br>
VJ_BEATFLASH - Same as VJ_BEAT, but it only gets set to 1 depending on FXFLASH value. If FXFLASH = 1, VJ_BEATFLASH will get to 1 only on the first beat (of 4). If FXFLASH = 3, it will get to 1 on the 2nd and 4th beats. There's a few variations.<br>
VJ_BEATTIME - Run time of application normalized to beats. It will go from 0 to 1 in the span of time it takes a beat (so it will change dynamically as you update BPM). It can be used to make your loops sync with the beat easy.<br>
VJ_BEATTIME4 - Same as VJ_BEATTIME, but will get from 0 to 1 in the spanof time it takes 4 beats.<br>
VJ_BEATLEN - The amount of time it takes for a beat to happen (it's the inverse of VJ_BEATTIME).<br>
VJ_BEATLEN4 - Same as VJ_BEATLEN3, but the amount of time it takes for 4 beats ot happen.

- DIY

It's very easy to create your own effects, and it's encouraged if you plan to do your own VJ gig!<br>
Make a new draw function for your effect, and make sure it runs at 60 fps, then add the function to the VJ_LOOPS array.<br>

- To Do

I am working on a simple TV Overlay effect, were users could write text for using the keyboard.<br>
