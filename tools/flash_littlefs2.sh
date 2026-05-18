. ~/projects/MicroPythonOS/claude/MicroPythonOS/lvgl_micropython/lib/esp-idf/export.sh

python3 -m esptool --chip esp32s3 -b 460800 --before default_reset --after hard_reset write_flash 0xb10000 littlefs2.bin 
