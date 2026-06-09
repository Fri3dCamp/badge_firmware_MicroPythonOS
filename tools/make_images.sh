mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")


. ~/projects/MicroPythonOS/claude/MicroPythonOS/lvgl_micropython/lib/esp-idf/export.sh

gen_esp32part.py --flash-size 16MB boards/shared/partitions.16mb.csv > partitions.16mb.bin

#esptool.py $(sed "s/write_flash/merge_bin -o full_2026.img/g" boards/2026/flash_args | sed "s/ --baud 460800//g")

mposdir="/home/user/projects/MicroPythonOS/claude/MicroPythonOS/lvgl_micropython/lib/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/"
retrodir="/home/user/sources/DukeNano3D/retro-go-for-DukeNano3D"

ls -al "$retrodir"/retro-core/build/retro-core.bin "$retrodir"/duke3d-go/build/duke3d-go.bin

python -m esptool --chip esp32s3 merge_bin --fill-flash-size=16MB --output image_fri3d_2024.bin 0x0 "$mposdir"/bootloader/bootloader.bin 0x8000 partitions.16mb.bin 0x10000 "$mposdir"/micropython.bin 0x710000 "$retrodir"/retro-core/build/retro-core.bin 0x800000 "$retrodir"/duke3d-go/build/duke3d-go.bin 0x900000 "$mydir"/../littlefs2_2024.bin

python -m esptool --chip esp32s3 merge_bin --fill-flash-size=16MB --output image_fri3d_2026.bin 0x0 "$mposdir"/bootloader/bootloader.bin 0x8000 partitions.16mb.bin 0x10000 "$mposdir"/micropython.bin 0x710000 "$retrodir"/retro-core/build/retro-core.bin 0x800000 "$retrodir"/duke3d-go/build/duke3d-go.bin 0x900000 "$mydir"/../littlefs2_2026.bin
