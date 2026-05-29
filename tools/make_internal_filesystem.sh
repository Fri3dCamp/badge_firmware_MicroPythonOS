#!/bin/bash

mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")

# retro-go launchers:
apps="com.micropythonos.duke_launcher com.micropythonos.retrocore_launcher" # not com.micropythonos.doom_launcher because doom is not included
# utilities:
apps="$apps com.micropythonos.imageview com.micropythonos.filemanager" # com.micropythonos.showfonts is just too damn slow
# demos
apps="$apps com.micropythonos.confetti com.micropythonos.imu"
# audio:
apps="$apps com.micropythonos.musicplayer com.micropythonos.soundrecorder"
# games:
apps="$apps com.micropythonos.connect4 com.quasikili.quasibird com.micropythonos.lights_out com.micropythonos.memory"
# utilities:
apps="$apps com.quasikili.quasinametag"
# optional hardware:
apps="$apps com.micropythonos.dj_addon"

# maybe:
# com.micropythonos.lora_chat # would be nice to exclude noise
# com.micropythonos.ir_remote # would be nice to have blaster support
# com.micropythonos.file_manager # when it's functional
# com.micropythonos.time_of_flight # too big, maybe when compiled .mpy

# Cleanups
pushd "$HOME/projects/MicroPythonOS/claude/MicroPythonOS"
./scripts/cleanup_pyc.sh
popd

appdir="$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/apps/"

app_args=()
for app in $apps; do
    app_args+=("$appdir/$app=/apps/$app/")
done


make_for_year() {

	year="$1"

	#"$HOME/ESP32_NES/microsd_final/roms/gbc/best/=/roms/gb/best" \
	#"$HOME/sources/DukeNano3D/outputs/E1L1-2_nearcomplete.grp.zip=/roms/duke3d/Episode_1_Level_1_and_2_nearcomplete.grp.zip" \

	"$mydir"/mklittlefs_pack.sh -s 0x700000 -o "$mydir"/../littlefs2_$year.bin \
	"internalsd/shared=/" \
	"internalsd/$year=/" \
	"$HOME/ESP32_NES/microsd_final/roms/gb/best/=/roms/gb/best" \
	"$HOME/sources/DukeNano3D/outputs/E1L1-6_nearcomplete.grp.zip=/roms/duke3d/Episode_1_All_6_Levels_nearcomplete.grp.zip" \
	"$HOME/ESP32_NES/microsd_final/romart/gb/2/2C27EC70.png=/romart/gb/2/2C27EC70.png" \
	"$HOME/ESP32_NES/microsd_final/roms/gbc/best/Chessmaster, The (USA).zip=/roms/gb/best/Chessmaster, The (USA).zip" \
	"$HOME/ESP32_NES/microsd_final/romart/gbc/1/1C13DBB0.png=/romart/gb/1/1C13DBB0.png" \
	"$HOME/ESP32_NES/microsd_final/roms/nes/best/=/roms/nes/best" \
	"$HOME/ESP32_NES/microsd_final/romart/nes/0/053014FF.png=/romart/nes/0/053014FF.png" \
	"$HOME/ESP32_NES/microsd_final/roms/nes/homebrew/2048 (Blurred Lines).zip=/roms/nes/homebrew/2048 (Blurred Lines).zip" \
	"$HOME/ESP32_NES/microsd_final/romart/nes/2048 (Blurred Lines).png=/romart/nes/2048 (Blurred Lines).png" \
	"$HOME/ESP32_NES/microsd_final/roms/gbc/homebrew/Columns_DX.zip=/roms/gb/homebrew/Columns_DX.zip" \
	"$HOME/ESP32_NES/microsd_final/romart/gbc/Columns_DX.png=/romart/gb/Columns_DX.png" \
	"${app_args[@]}"

}

make_for_year 2024
make_for_year 2026
