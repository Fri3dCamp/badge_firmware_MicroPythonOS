variant="$1"
if [ -z "$variant" ]; then
	echo "Usage: $0 variant"
	echo "Usage: $0 2024"
	echo "Usage: $0 2026"
	exit 1
fi
python=$(ls -tr ~/.espressif/python_env/*/bin/python|tail -1)
$python -m esptool --chip esp32s3 --before default_reset --after hard_reset write_flash --flash_mode dio --flash_size 16MB --flash_freq 80m 0 image_fri3d_$variant.bin
