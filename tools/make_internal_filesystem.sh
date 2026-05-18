mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")

apps="com.micropythonos.duke_launcher com.micropythonos.doom_launcher com.micropythonos.nes_launcher com.micropythonos.gameboy_launcher"
apps="$apps com.micropythonos.imageview com.micropythonos.confetti com.micropythonos.connect4 com.micropythonos.dj_addon com.micropythonos.musicplayer"
apps="$apps com.quasikili.quasibird com.quasikili.quasinametag"

appdir="$HOME/projects/MicroPythonOS/claude/MicroPythonOS/internal_filesystem/apps/"

app_args=()
for app in $apps; do
    app_args+=("$appdir/$app=/apps/$app/")
done

"$mydir"/mklittlefs_pack.sh -s 0x4F0000 -o "$mydir"/../littlefs2.bin \
"$HOME/sources/DukeNano3D/outputs/E1L1-2_compromise.grp.zip=/roms/duke3d/Shareware_E1L1-2_compromise.grp.zip" \
"$HOME/ESP32_NES/microsd_final/roms/gb/best/=/roms/gb/best" \
"$HOME/ESP32_NES/microsd_final/roms/gbc/best/=/roms/gb/best" \
"$HOME/ESP32_NES/microsd_final/roms/nes/best/=/roms/nes/best" \
"$HOME/ESP32_NES/internalsd_zips/roms/nes/homebrew/2048 (Blurred Lines).zip=/roms/nes/homebrew/2048 (Blurred Lines).zip" \
"$HOME/ESP32_NES/internalsd_zips/roms/gbc/homebrew/Columns_DX.zip=/roms/gb/homebrew/Columns_DX.zip" \
"${app_args[@]}"
