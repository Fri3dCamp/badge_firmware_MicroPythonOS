mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")

#"$HOME/ESP32_NES/internalsd_zips/roms/doom/=/roms/doom/" \
#"$HOME/ESP32_NES/internalsd_zips/roms/gb/homebrew/=/roms/gb/homebrew" \
#"$HOME/ESP32_NES/internalsd_zips/roms/gbc/homebrew/=/roms/gb/homebrew" \
#"$HOME/ESP32_NES/internalsd_zips/roms/nes/homebrew/=/roms/nes/homebrew" \

"$mydir"/mklittlefs_pack.sh -s 0x4F0000 -o "$mydir"/../littlefs2.bin \
"$HOME/sources/DukeNano3D/outputs/E1L1-2_compromise.grp.zip=/roms/duke3d/Shareware_E1L1-2_compromise.grp.zip" \
"$HOME/ESP32_NES/microsd_final/roms/gb/best/=/roms/gb/best" \
"$HOME/ESP32_NES/microsd_final/roms/gbc/best/=/roms/gb/best" \
"$HOME/ESP32_NES/microsd_final/roms/nes/best/=/roms/nes/best" \
"$HOME/ESP32_NES/internalsd_zips/roms/nes/homebrew/2048 (Blurred Lines).zip=/roms/nes/homebrew/2048 (Blurred Lines).zip" \
"$HOME/ESP32_NES/internalsd_zips/roms/gbc/homebrew/Columns_DX.zip=/roms/gb/homebrew/Columns_DX.zip"


