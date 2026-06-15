#!/bin/bash

mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")

debug="$1"

# retro-go launchers:
apps="com.micropythonos.duke_launcher com.micropythonos.retrocore_launcher" # not com.micropythonos.doom_launcher because doom is not included
# utilities:
apps="$apps com.micropythonos.imageview com.micropythonos.file_manager com.quasikili.quasicalculator"
# demos
apps="$apps com.micropythonos.confetti com.micropythonos.showfonts"
# hardware tests
apps="$apps com.micropythonos.imu com.micropythonos.time_of_flight com.micropythonos.lora_chat com.micropythonos.ir_remote com.micropythonos.showbattery"
# audio:
apps="$apps com.micropythonos.musicplayer com.micropythonos.soundrecorder"
# games:
apps="$apps com.micropythonos.connect4 com.quasikili.quasibird com.micropythonos.lights_out com.micropythonos.memory"
# utilities:
apps="$apps com.quasikili.quasinametag"
# optional hardware:
apps="$apps com.micropythonos.dj_addon"

# Cleanups
pushd "$HOME/projects/MicroPythonOS/claude/MicroPythonOS"
./scripts/cleanup_pyc.sh
popd

mposdir="$HOME/projects/MicroPythonOS/claude/MicroPythonOS"
appdir="$mposdir/internal_filesystem/apps/"

extra=()
extra+=("$HOME/ESP32_NES/microsd_final/romart/gbc/Columns_DX.png=/romart/gbc/Columns_DX.png")
extra+=("$HOME/ESP32_NES/microsd_final/roms/gbc/homebrew/Columns_DX.zip=/roms/gbc/homebrew/Columns_DX.zip")
if [ -z "$debug" ]; then
	#extra+=("$HOME/sources/DukeNano3D/outputs_precalculated_pngs_pngquant_40-71_2_iterations_500/E1L1-3_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_to_3_compromise.grp.zip")
	#extra+=("$HOME/sources/DukeNano3D/outputs/E1L1-2_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_to_2_compromise.grp.zip")
	extra+=("$HOME/sources/DukeNano3D/outputs_onlysmaller_replaceskyline/E1L1-3_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_to_3_compromise.grp.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/gg/Sonic The Hedgehog - Triple Trouble (USA, Europe, Brazil).zip=/roms/gg/Sonic The Hedgehog - Triple Trouble (USA, Europe, Brazil).zip")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/lnx/Turbo Sub (1991) [a1].lnx.zip=/roms/lnx/Turbo Sub (1991) [a1].lnx.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/lnx/Warbirds (1990) [o1].lnx.zip=/roms/lnx/Warbirds (1990) [o1].lnx.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/sms/europe/Castle of Illusion Starring Mickey Mouse (E).sms.zip=/roms/sms/Castle of Illusion Starring Mickey Mouse (E).sms.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/col/Zaxxon (1982) (Sega) [b1].rom.zip=/roms/col/Zaxxon (1982) (Sega) [b1].rom.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/gb/best/=/roms/gb/")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/2/2C27EC70.png=/romart/gb/2/2C27EC70.png")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/gbc/best/=/roms/gbc/")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gbc/1/1C13DBB0.png=/romart/gbc/1/1C13DBB0.png")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/nes/best/=/roms/nes/")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/0/053014FF.png=/romart/nes/0/053014FF.png")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/nes/homebrew/2048 (Blurred Lines).zip=/roms/nes/homebrew/2048 (Blurred Lines).zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/2048 (Blurred Lines).png=/romart/nes/2048 (Blurred Lines).png")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/pce/World Court Tennis (U).pce.zip=/roms/pce/World Court Tennis (U).pce.zip")
	# Precompiling the apps saves around 156KiB and makes them faster to start
	compiledappdir="/tmp/compiled_app_dir"
	"$mposdir"/scripts/compile_dir.sh "$appdir" "$compiledappdir"
	appdir="$compiledappdir"
else
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/builtin=/builtin")
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/lib=/lib")
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/main.py=/main.py")
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/data/com.micropythonos.system.wifiservice/config.json=/data/com.micropythonos.system.wifiservice/config.json")
fi

#"$HOME/ESP32_NES/microsd_final/roms/gbc/best/=/roms/gb/best" \
#"$HOME/sources/DukeNano3D/outputs/E1L1-6_nearcomplete.grp.zip=/roms/duke3d/Episode_1_All_6_Levels_nearcomplete.grp.zip" \
# The Game & Watch ones are huge:
#"$HOME/ESP32_NES/microsd_final/roms/gw/Mickey Mouse (Nintendo, Wide Screen).mgw=/roms/gw/Mickey Mouse (Nintendo, Wide Screen).mgw" \
#"$HOME/ESP32_NES/microsd_final/roms/gbc/best/Chessmaster, The (USA).zip=/roms/gbc/best/Chessmaster, The (USA).zip" \
#"$HOME/ESP32_NES/microsd_final/roms/gg/Tails' Sky Patrol (J) [!].gg.zip=/roms/gg/Tails' Sky Patrol (J) [!].gg.zip" \
#"$HOME/ESP32_NES/microsd_final/roms/gg/GG Shinobi II, The ~ Shinobi II - The Silent Fury (World).zip=/roms/gg/GG Shinobi II, The ~ Shinobi II - The Silent Fury (World).zip" \
#"$HOME/ESP32_NES/microsd_final/roms/sms/world/Sonic The Hedgehog (UE).sms.zip=/roms/sms/world/Sonic The Hedgehog (UE).sms.zip" \
#"$HOME/sources/DukeNano3D/outputs/E1L1-6_pngquant1.grp.zip=/roms/duke3d/E1L1-6_pngquant1.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs/E1L1-2_nearcomplete.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_and_2_nearcomplete.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs/E1L1-6_pngquant3.grp.zip=/roms/duke3d/E1L1-6_pngquant3.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs_shareware/E1L1-2_nearcomplete.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_and_2_nearcomplete.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs/E1L1-2_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_and_2_compromise.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs/E1L1-2_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_and_2_compromise.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs/E1-3L1_compromise.grp.zip=/roms/duke3d/E1-3L1_compromise.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs_precalculated_pngs_pngquant_40-71_2_iterations_500/E1L1-2_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_and_2_compromise.grp.zip" \
#"$HOME/sources/DukeNano3D/outputs_precalculated_pngs_pngquant_40-71_2_iterations_500/E1L1-6_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_to_6_compromise.grp.zip" \


app_args=()
for app in $apps; do
    app_args+=("$appdir/$app=/apps/$app/")
done


make_for_year() {
	year="$1"

	rm "$mydir"/../littlefs2_$year.bin
	# -m 1024 -r 256: inline_max = min(1024, 1022, 512) = 512 bytes. Files ≤512 B get inlined during image creation
	"$mydir"/mklittlefs_pack.sh -b 4096 -r 256 -m 1024  -s 0x700000 -o "$mydir"/../littlefs2_$year.bin \
        "internalsd/shared=/" \
	"internalsd/$year=/" \
	"${extra[@]}" \
	"${app_args[@]}"

}

make_for_year 2024
make_for_year 2026

echo "Extracting..."
cd "$mydir"
rm -rf ../extract
mkdir ../extract
~/sources/mklittlefs/mklittlefs -u ../extract/ "$mydir"/../littlefs2_2026.bin 
