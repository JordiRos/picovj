# PicoVJ

A functional VJ framework for PICO8! It's very scoped but still should be usable in a real gig with a single controller (6 buttons).

# Instructions 

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

FXRAGE is the hype value of the application, and how it behaves depends on each scene implementation. A scene at FXRAGE = 0 would be simple, slow, but the same scene at FXRAGE = 1 would be much faster and frenzy.<br>
FXFLASH will define when the BEATFLASH is set, and again it is up to the scene  to implement.

- Expand!

It's easy to create your own scenes, so go for it!<br>
Make a new draw function for your scene, and make sure it runs at 60 fps, then add the function to the VJ_LOOPS array.<br>
When writing your own scene, you can use these VJ variables for easy sync:

VJ_TIME - Real run time of application (float, in seconds).<br>
VJ_BPM - Current BPM.<br>
VJ_BEAT - Set to 1 on every beat, fading out to 0 in a few frames.<br>
VJ_BEATFLASH - Same as VJ_BEAT, but it only gets set to 1 depending on FXFLASH value. If FXFLASH = 1, VJ_BEATFLASH will be 1 only on the first beat (of 4). If FXFLASH = 3, it will be 1 on the 2nd and 4th beats.<br>
VJ_BEATTIME - Run time of application normalized to beats. It will go from 0 to 1 in the span of time it takes a beat (so it will change dynamically as you update BPM). <br>
VJ_BEATLEN - The amount of time it takes for a beat to happen (it's the inverse of VJ_BEATTIME).<br>
VJ_BEATNUM - Number of current beat, from 0 to 3.<br>

Enjoy!
