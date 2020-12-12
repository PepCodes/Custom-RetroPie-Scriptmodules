# Custom RetroPie Scriptmodules
A (hopefully soon-to-be) collection of game and app scriptmodules for the RetroPie Setup script, specifically targeting the Raspberry Pi.

## Disclaimer
This is an unofficial solo project by someone who wanted to get their favorite software working on RetroPie and share the results with others. This is *not* a part of the RetroPie project, *nor* is it endorsed by the original developers of the software being ported. Any issues with these scriptmodules specifically should be brought to me. I welcome constructive feedback, however use of these scriptmodules is still at your own risk.

## Installation
1. Clone this repo using Git or download it as a .ZIP archive.
2. Merge the `scriptmodules` folder into `~/RetroPie-Setup` in your home directory.
3. Start RetroPie Setup with `cd ~/RetroPie-Setup; sudo ./retropie_setup.sh` and install your chosen scriptmodules. All scriptmodules from this repo will be categorized as "exp"/"Experimental".
4. Close RetroPie Setup and start/restart EmulationStation. Your newly installed software should be detected and available to run. Ports can be accessed from the *Ports* menu.

## Ports
### Sonic Robo Blast 2 Kart (Pi 4/400 only)
#### A kart racing mod for Sonic Robo Blast 2, a 3D Sonic the Hedgehog fan-game built off of Doom Legacy with a time attack mode, custom addons and online multiplayer. https://github.com/STJr/Kart-Public
Dependencies: `libsdl2-dev` `libsdl2-mixer-dev` `libpng-dev`

+ Compiles and installs version 1.3. Support for version 2.0 will be considered once it is released.
+ For installation, please allow up to 400 MB of storage to download and extract game assets.
+ Only software mode is available due to unstable frame rates at higher internal and upscaled resolutions in OpenGL mode.
+ On a Raspberry Pi 400 at stock settings, performance at 320x(200|240) internal resolution can range between 25-35 fps. depending on visual complexity. At 640x(400|480), performance can range between 20-30 fps. with rare spikes to 35 fps. Upscaling to your display's resolution may introduce a small performance hit.
+ XInput-compatible controllers should be recognized right away at launch. However, a keyboard should be made available in the event of a controller input issue.
+ As with a traditional installation of the game, the configuration file `kartconfig.cfg`, as well as replays, server content downloads and addons are stored in `~/.srb2kart`. You can make changes to the configuration file by dropping to a shell prompt from EmulationStation, or accessing your Raspberry Pi over SSH after enabling it within `raspi-config`.
+ Some text elements may be unreadable at 320x(200|240). You may want to launch the game at 640x(400|480), then lower the resolution once in a server or match.
+ For online play, please be considerate to other players by...
	+ ...using a wired Ethernet connection
	+ ...choosing a server closest to your location
	+ ...ensuring your setup is capable of handling potentially complex custom courses, preferably with at least 2+ GB of available RAM.