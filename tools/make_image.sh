mydir=$(readlink -f "$0")
mydir=$(dirname "$mydir")


. ~/projects/MicroPythonOS/claude/MicroPythonOS/lvgl_micropython/lib/esp-idf/export.sh

gen_esp32part.py --flash-size 16MB boards/shared/partitions.16mb.csv > partitions.16mb.bin

#esptool.py $(sed "s/write_flash/merge_bin -o full_2026.img/g" boards/2026/flash_args | sed "s/ --baud 460800//g")

outdir="/home/user/projects/MicroPythonOS/claude/MicroPythonOS/lvgl_micropython/lib/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/"
python -m esptool --chip esp32s3 merge_bin --fill-flash-size=16MB --output image_esp32s3.bin 0x0 "$outdir"/bootloader/bootloader.bin 0x8000 partitions.16mb.bin 0x10000 "$outdir"/micropython.bin 0x710000 ~/sources/DukeNano3D/retro-go-for-DukeNano3D/retro-core/build/retro-core.bin 0x800000 ~/sources/DukeNano3D/retro-go-for-DukeNano3D/duke3d-go/build/duke3d-go.bin 0x900000 "$mydir"/../littlefs2_2026.bin
