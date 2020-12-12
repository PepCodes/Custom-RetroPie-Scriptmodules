#!/usr/bin/env bash

# Sonic Robo Blast 2 Kart for RetroPie for Raspberry Pi 4/400
#
# Scriptmodule based off of the official RetroPie scriptmodule for Sonic Robo Blast 2:
# https://github.com/RetroPie/RetroPie-Setup/blob/master/scriptmodules/ports/srb2.sh
# Original additions/modifications by Ed Peppe, https://github.com/PepCodes

rp_module_id='srb2kart'
rp_module_desc='Sonic Robo Blast 2 Kart'
rp_module_help='A kart racing mod for Sonic Robo Blast 2, a 3D Sonic the Hedgehog fan-game built off of Doom Legacy with a time attack mode, custom addons and online multiplayer.'
rp_module_license='GPL2 https://raw.githubusercontent.com/STJr/Kart-Public/master/LICENSE'
rp_module_section='exp'
rp_module_flags='!all rpi4'

function depends_srb2kart() {
	# Check for and install SDL 2, SDL 2 Mixer, and PNG support.
	getDepends libsdl2-dev libsdl2-mixer-dev libpng-dev
}

function sources_srb2kart() {
	# Clone the source.
	gitPullOrClone "$md_build" https://github.com/STJr/Kart-Public.git

	# Get and extract assets. Was not able to extract specific
	# files using downloadAndExtract(), so using download()/unzip/rm instead.
	cd "$md_build/assets"
	download 'https://github.com/STJr/Kart-Public/releases/download/v1.3/srb2kart-v13-installer.exe' "installer.exe"
	unzip -o "installer.exe" *.kart *.srb HISTORY.txt LICENSE.txt LICENSE-3RD-PARTY.txt
	rm "installer.exe"
}

function build_srb2kart() {
	# Compile for 64-bit Linux on all threads, and without
	# hardware acceleration, GME music playback, x86 assembly
	# since we're compiling specifically for ARM, or UPX.
	local makeargs="-j"$(nproc)" -C src/ LINUX64=1 NOHW=1 NOGME=1 NOASM=1 NOUPX=1"

	make $makeargs clean
	make $makeargs

	md_ret_require="$md_build/bin/Linux64/Release/lsdl2srb2kart"
}

function install_srb2kart() {
	# Install the compiled binary and the assets
	# to the appropriate directory.
	cp -L 'bin/Linux64/Release/lsdl2srb2kart' "$md_inst/srb2kart"
	md_ret_files=(
		'assets/bonuschars.kart'
		'assets/chars.kart'
		'assets/gfx.kart'
		'assets/HISTORY.txt'
		'assets/LICENSE.txt'
		'assets/LICENSE-3RD-PARTY.txt'
		'assets/maps.kart'
		'assets/music.kart'
		'assets/patch.kart'
		'assets/sounds.kart'
		'assets/srb2.srb'
		'assets/textures.kart'
	)
}

function configure_srb2kart() {
	# Add a launcher for the game as a port.
	addPort "$md_id" "srb2kart" "Sonic Robo Blast 2 Kart" "$md_inst/srb2kart"

	# Create a symlink for the config folder as the
	# ~/.srb2kart directory that the game expects.
	moveConfigDir "$home/.srb2kart" "$md_conf_root/$md_id"

	# Symlink the assets so the game can find them
	# without any extra configuration.
	cd "$home/.srb2kart"
	ln -sf $md_inst/{*.kart,*.srb} "."
}
