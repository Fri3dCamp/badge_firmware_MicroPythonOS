# Fri3d Camp Badge firmware based on MicroPythonOS

This repository holds the main firmware for the Fri3d Camp 2024 and 2026 badges, with MicroPythonOS as the main OS, responsible for Over-The-Air updates.

## Partition layout

Total internal flash size: 16384KB

Parittions should be aligned to 64KB

```
64KB preamble: 
- 0x0 images/bootloader.bin
- 0x8000 images/partition-table.bin
- 0x9000 otadata (size 0x2000)
- 0xb000 nvs (size 0x5000)

4096KB ota0

4096KB ota1

1024KB app partition (retro-core?)
1024KB app partition (Duke3D? Doom? Quake? Wolfenstein? OpenLara? Arduino? Free?)
1024KB app partition

5MB-64KB storage:
	- 512KB NES games
	- 512KB GB games
  - 512KB preinstalled apps
	- 1024KB other game data files
	- 2000KB free for apps and artwork
```
