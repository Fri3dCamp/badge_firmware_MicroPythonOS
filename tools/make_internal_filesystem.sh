#!/bin/bash

mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")

debug="$1"
if [ "$debug" == "2024" -o "$debug" == "2026" ]; then
	echo "You used 2024 or 2026 as an argument but this script does both!"
	echo "Usage: $0 [debug]"
	exit 1
fi

# retro-go launchers:
apps="com.micropythonos.duke_launcher com.micropythonos.retrocore_launcher" # not com.micropythonos.doom_launcher because doom is not included
# utilities:
apps="$apps com.micropythonos.imageview com.quasikili.quasicalculator com.quasikili.quasinametag com.micropythonos.texteditor"
# demos
apps="$apps com.micropythonos.confetti"
# hardware tests
apps="$apps com.micropythonos.imu com.micropythonos.time_of_flight com.micropythonos.lora_chat com.micropythonos.ir_remote com.micropythonos.showbattery"
# audio:
# com.micropythonos.thefreelanternplayer needs work
apps="$apps com.micropythonos.musicplayer com.micropythonos.soundrecorder"
# games:
apps="$apps com.micropythonos.connect4 com.quasikili.quasibird com.micropythonos.lights_out com.micropythonos.memory com.micropythonos.breakout com.micropythonos.sorter"
# comms:
apps="$apps com_micropythonos_nostr com.quasikili.wikipedia"
# optional hardware:
apps="$apps com.micropythonos.dj_addon"

# Cleanups
pushd "$HOME/projects/MicroPythonOS/claude/MicroPythonOS"
./scripts/cleanup_pyc.sh
popd

mposdir="$HOME/projects/MicroPythonOS/claude/MicroPythonOS"
appdir="$mposdir/internal_filesystem/apps/"

extra=()
if [ -z "$debug" ]; then
	extra+=("$HOME/sources/DukeNano3D/outputs_fix_FEM1/E1L1-4_compromise.grp.zip=/roms/duke3d/Shareware_Ep_1_Level_1_to_4_compromise.grp.zip")

	extra+=("$HOME/ESP32_NES/microsd_final/roms/gg/Sonic The Hedgehog - Triple Trouble (USA, Europe, Brazil).zip=/roms/gg/Sonic The Hedgehog - Triple Trouble (USA, Europe, Brazil).zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gg/Sonic The Hedgehog - Triple Trouble (USA, Europe, Brazil).png=/romart/gg/Sonic The Hedgehog - Triple Trouble (USA, Europe, Brazil).png")

	extra+=("$HOME/ESP32_NES/microsd_final/roms/lnx/Turbo Sub (1991) [a1].lnx.zip=/roms/lnx/Turbo Sub (1991) [a1].lnx.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/lnx/Turbo Sub (1991) [a1].png=/romart/lnx/Turbo Sub (1991) [a1].png")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/lnx/Warbirds (1990) [o1].lnx.zip=/roms/lnx/Warbirds (1990) [o1].lnx.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/lnx/Warbirds (1990) [o1].png=/romart/lnx/Warbirds (1990) [o1].png")

	extra+=("$HOME/ESP32_NES/microsd_final/roms/sms/world/Rampage (UE).sms.zip=/roms/sms/Rampage (UE).sms.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/sms/Rampage (UE).png=/romart/sms/Rampage (UE).png")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/sms/brazil/Baku Baku Animal (BR).sms.zip=/roms/sms/Baku Baku Animal (BR).sms.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/sms/Baku Baku Animal (BR).png=/romart/sms/Baku Baku Animal (BR).png")

	extra+=("$HOME/ESP32_NES/microsd_final/roms/col/Zaxxon (1982) (Sega) [b1].rom.zip=/roms/col/Zaxxon (1982) (Sega) [b1].rom.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/col/Zaxxon (1982) (Sega) [b1].png=/romart/col/Zaxxon (1982) (Sega) [b1].png")

	extra+=("$HOME/ESP32_NES/internalsd_zips_2026/roms/gb/homebrew=/roms/gb/homebrew") # 72KB
	extra+=("$HOME/ESP32_NES/internalsd_zips_2026/romart/gb=/romart/gb") # 15KB

	extra+=("$HOME/ESP32_NES/microsd_final/roms/gb/best/=/roms/gb/")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/0/0E0216E6.png=/romart/gb/4-in-1 Fun Pak (USA, Europe).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/6/6C41D3CD.png=/romart/gb/Batman - The Video Game (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/E/ED6771DB.png=/romart/gb/Ferrari Grand Prix Challenge (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/6/6ED10383.png=/romart/gb/Golf (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/A/A662A8EF.png=/romart/gb/Looney Tunes (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/7/7B822D8F.png=/romart/gb/Mickey's Dangerous Chase (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/3/318DBDE1.png=/romart/gb/Motocross Maniacs (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/6/6DA713E3.png=/romart/gb/Pinball Dreams (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/5/5D8DEB5B.png=/romart/gb/Star Wars (USA) (Rev-A).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/2/2C27EC70.png=/romart/gb/Super Mario Land (USA) (Rev-A).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/5/5009215F.png=/romart/gb/Tennis (USA).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gb/0/0636D89E.png=/romart/gb/Tom and Jerry (USA).png")


	extra+=("$HOME/ESP32_NES/microsd_final/roms/gbc/best/=/roms/gbc/")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/gbc/8/8E6F8037.png=/romart/gbc/Battleship - The Classic Naval Combat Game (USA).png")

	extra+=("$HOME/ESP32_NES/microsd_final/romart/gbc/Columns_DX.png=/romart/gbc/Columns_DX.png")
	extra+=("$HOME/ESP32_NES/microsd_final/roms/gbc/homebrew/Columns_DX.zip=/roms/gbc/homebrew/Columns_DX.zip")

	extra+=("$HOME/ESP32_NES/microsd_final/roms/nes/best/=/roms/nes/")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/B/B668C7FC.png=/romart/nes/Castlevania (USA) (Rev 1).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/6/6F97C721.png=/romart/nes/Donkey Kong (World) (Rev 1).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/E/EAF7ED72.png=/romart/nes/Legend of Zelda, The (USA) (Rev 1).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/4/43D30C2F.png=/romart/nes/Ms. Pac-Man (USA) (Tengen) (Unl).png")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/C/CA594ACE.png=/romart/nes/Super Mario Bros. 2 (USA) (Rev 1).png")


	extra+=("$HOME/ESP32_NES/microsd_final/roms/nes/homebrew/2048 (Blurred Lines).zip=/roms/nes/homebrew/2048 (Blurred Lines).zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/nes/2048 (Blurred Lines).png=/romart/nes/2048 (Blurred Lines).png")

	extra+=("$HOME/ESP32_NES/microsd_final/roms/pce/World Court Tennis (U).pce.zip=/roms/pce/World Court Tennis (U).pce.zip")
	extra+=("$HOME/ESP32_NES/microsd_final/romart/pce/World Court Tennis (U).png=/romart/pce/World Court Tennis (U).png")

	# Too big and not great:
	#extra+=("$HOME/ESP32_NES/internalsd_zips_2026/roms/nes/homebrew/=/roms/nes/homebrew") # 1111KB
	#extra+=("$HOME/ESP32_NES/internalsd_zips_2026/romart/nes/=/romart/nes") # 71KB
	#extra+=("$HOME/ESP32_NES/internalsd_zips_2026/roms/gbc/homebrew=/roms/gbc/homebrew") # 778KB
	#extra+=("$HOME/ESP32_NES/internalsd_zips_2026/romart/gbc=/romart/gbc") # 66KB

	# Precompiling the apps saves around 156KiB and makes them faster to start
	compiledappdir="/tmp/compiled_app_dir"
	rm -rf "$compiledappdir"
	"$mposdir"/scripts/compile_dir.sh -march=xtensawin "$appdir" "$compiledappdir"
	appdir="$compiledappdir"
else
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/builtin=/builtin")
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/lib=/lib")
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/main.py=/main.py")
	extra+=("$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/data/prefs/com.micropythonos.system.wifiservice/config.json=/data/com.micropythonos.system.wifiservice/config.json")
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

	rm -f "$mydir"/../littlefs2_$year.bin
	# -m 1024 -r 256: inline_max = min(1024, 1022, 512) = 512 bytes. Files ≤512 B get inlined during image creation
	"$mydir"/mklittlefs_pack.sh -b 4096 -r 256 -m 1024  -s 0x700000 -o "$mydir"/../littlefs2_$year.bin \
        "internalsd/shared=/" \
	"internalsd/$year=/" \
	"${extra[@]}" \
	"${app_args[@]}"

}

make_for_year 2026
#make_for_year 2024
cp "$mydir"/../littlefs2_2026.bin "$mydir"/../littlefs2_2024.bin


echo "Extracting..."
cd "$mydir"
rm -rf ../extract
mkdir ../extract
~/sources/mklittlefs/mklittlefs -u ../extract/ "$mydir"/../littlefs2_2026.bin 
