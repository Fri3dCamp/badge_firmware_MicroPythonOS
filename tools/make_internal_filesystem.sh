#!/bin/bash

mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")

apps="com.micropythonos.duke_launcher com.micropythonos.doom_launcher com.micropythonos.nes_launcher com.micropythonos.gameboy_launcher"
# utilities:
apps="$apps com.micropythonos.imageview"
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
# com.micropythonos.time_of_flight # too big

# Cleanups
pushd "$HOME/projects/MicroPythonOS/claude/MicroPythonOS"
./scripts/cleanup_pyc.sh
popd

appdir="$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/apps/"

app_args=()
for app in $apps; do
    app_args+=("$appdir/$app=/apps/$app/")
done
#
"$HOME/ESP32_NES/microsd_final/roms/gbc/best/=/roms/gb/best" \

"$mydir"/mklittlefs_pack.sh -s 0x4F0000 -o "$mydir"/../littlefs2.bin \
"internalsd_2026/=/" \
"$HOME/sources/DukeNano3D/outputs/E1L1-2_compromise.grp.zip=/roms/duke3d/Shareware_E1L1-2_compromise.grp.zip" \
"$HOME/ESP32_NES/microsd_final/roms/gb/best/=/roms/gb/best" \
"$HOME/ESP32_NES/microsd_final/romart/gb/2/2C27EC70.png=/romart/gb/2/2C27EC70.png" \
"$HOME/ESP32_NES/microsd_final/roms/gbc/best/Chessmaster, The (USA).zip=/roms/gb/best/Chessmaster, The (USA).zip" \
"$HOME/ESP32_NES/microsd_final/romart/gbc/1/1C13DBB0.png=/romart/gb/1/1C13DBB0.png" \
"$HOME/ESP32_NES/microsd_final/roms/nes/best/=/roms/nes/best" \
"$HOME/ESP32_NES/internalsd_zips/roms/nes/homebrew/2048 (Blurred Lines).zip=/roms/nes/homebrew/2048 (Blurred Lines).zip" \
"$HOME/ESP32_NES/internalsd_zips/roms/gbc/homebrew/Columns_DX.zip=/roms/gb/homebrew/Columns_DX.zip" \
"${app_args[@]}"
