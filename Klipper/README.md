# Overview
Bikin Toolchanger is using pure macros. It uses snippets of codes from the [Magswitch](https://github.com/jera-sea/MagSwitch-Toolchanger) project and the
[Klicky Probe](https://github.com/jlas1/Klicky-Probe).

# Nudge Tool
Nudge tool was created by [zruncho](https://github.com/zruncho3d/nudge). It provides a very accurate and convenient way to align nozzles for toolchangers.
Btc provided macros to utilize the tool for nozzle alignment. Instructions for use are [here](https://github.com/Bikin-Creative/Lineux-Toolchanger/blob/main/Manual/NUDGE.md).

# Macro Status
Fully tested and working. Released.
TODO:
1. Crash Detection

# Instructions
Instructions are [here](https://github.com/Bikin-Creative/Lineux-Toolchanger/blob/main/Manual/KLIPPER.md)

# Files
1. btc.cfg <- Main file, required
2. btc_variables.cfg <- Variables, required
3. tool_x.cfg <- Individual tool settings, required
4. bashed_macros.cfg <- For stress testing of toolchanger, required after set up
5. btc_nudge.cfg <- Macros for nudge tool, required during set up
6. btc_klicky <- Required if using klicky probe
7. btc_extras <- Sample macros to use in start/end print
8. leds_x.cfg <- Required if using led effect