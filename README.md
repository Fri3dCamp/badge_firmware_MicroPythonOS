# Fri3d Camp Badge firmware based on MicroPythonOS

This repository holds the main firmware for the Fri3d Camp 2024 and 2026 badges, with MicroPythonOS as the main OS, responsible for Over-The-Air updates.

## Partition layout

Total internal flash size: 16384KB

Paritions should be aligned to 64KB

64KB preamble: 
- 0x0 images/bootloader.bin
- 0x8000 images/partition-table.bin
- 0x9000 otadata (size 0x2000)
- 0xb000 nvs (size 0x5000)

MicroPythonOS:
- 4096KB ota0
- 4096KB ota1

These could be slightly smaller, down to 3712KiB or even 3584KiB, but let's not forget to leave spare room for future growth.

App partitions:
- 1024KB retro-core (NES, GameBoy, GameBoy Color, etc)
- 1024KB duke3d-go (Duke Nukem 3D)
- 1024KB Doom? Quake? Wolfenstein? OpenLara? Arduino? Free? [OutRun-style 3D game](https://github.com/davidmonterocrespo24/esp32s3-arcade-3d)?

5MB-64KB LittleFS2 storage:
	- 1721 KB E1L1-2_compromise.grp.zip of [DukeNano3D](https://github.com/ThomasFarstrike/DukeNano3D)
	- 512 KB preinstalled MicroPythonOS apps (Retro-Go Launcher, Duke Nukem 3d Launcher, Fri3d Camp App? QuasiBird?)
	- 512 KB NES games
	- 512 KB GB games
	- 1863 KB free for more apps and artwork

