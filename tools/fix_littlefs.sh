echo "add back the 0xff 0xff 0xff bytes that are removed from littlefs.bin to workaround a bug in https://fri3d-flasher.vercel.app/"
python3 -c "from pathlib import Path; p=Path('littlefs2.bin'); p.write_bytes(p.read_bytes()+b'\xff\xff\xff')"
