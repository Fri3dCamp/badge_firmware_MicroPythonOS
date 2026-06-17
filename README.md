# Fri3d Camp Badge firmware based on MicroPythonOS

This repository holds the main firmware for the Fri3d Camp 2024 and 2026 badges.

It uses [MicroPythonOS](https://MicroPythonOS.com) as the main operating system and [Retro-Go](https://github.com/ducalex/retro-go) for dedicated gaming partitions.

## Partition layout

Total internal flash size: 16384KB

Partitions should be aligned to 64KB

64KB preamble: 
- 0x0 images/bootloader.bin
- 0x8000 images/partition-table.bin
- 0x9000 otadata (size 0x2000)
- 0xb000 nvs (size 0x5000)

MicroPythonOS:
- 3584 KiB = 3.5 MiB ota0
- 3584 KiB = 3.5 MiB ota1

The current *unified* ESP32S3 build that has support for all ESP32S3-based devices
that MicroPythonOS supports is 3476 KiB in size, so this leaves 108 KiB for future growth.

If at some point in the future, that turns out not to be enough, further size optimization can be achieved
by making a *non-unified*, custom build for the Fri3d Camp badges, excluding all unnecessary drivers and board support.

Note that this is not a miracle space saver, as these are "frozen" (precompiled and builtin) so they don't take up that much space anyhow.
But it could save an estimated 100 KiB, maybe 150 KiB, so that should provide enough leeway in case it's ever needed.

App partitions:

- 1024 - 64 KiB (taken by preamble) for retro-core to emulate Nintendo Entertainment System, GameBoy, GameBoy Color, Game & Watch, Sega Master System, Game Gear, Coleco ColecoVision, NEC PC Engine and Atari Lynx
- 1024KB duke3d-go (Duke Nukem 3D)

7 MiB LittleFS2 storage:

- 2 MiB GameBoy, NES, Sega games + cover art
- 1.7 MiB [Duke Nano 3D](https://github.com/ThomasFarstrike/DukeNano3D) Duke Nukem 3D Shareware, repacked for size with 4 of the 6 levels included
- 1 MiB MicroPythonOS apps (Retro-Core Launcher, Duke Nukem 3D Launcher, lots of other games, apps and utilities)
- 0.2 MiB custom boot_splash.png, sample images, sample audio, configuration files

= 4.6 MiB

+ 1.75 MiB LittleFS2 filesystem overhead (6.4 KiB per file, quite a lot!)

Leaves: 0.75 MiB free space (for savegames, sound recordings, high scores, etc.)

# Notes

- The config file `internalsd/2026/retro-go/config/global.json` is currently set to "buzzer" to have some audio out, so to have headset output, the user has to change this in the Duke Launcher settings. This could be automated (for example, detecting the Communicator Add-On) but for now it's manual.

