# Overview
Bikin Toolchanger is using pure macros. It uses snippets of codes from the [Magswitch](https://github.com/jera-sea/MagSwitch-Toolchanger) project and the
[Klicky Probe](https://github.com/jlas1/Klicky-Probe).

# Nudge Tool
Nudge tool was created by [zruncho](https://github.com/zruncho3d/nudge). It provides a very accurate and convenient way to align nozzles for toolchangers.
Btc provided macros to utilize the tool for nozzle alignment. Instructions for use are coming, but you may follow instructions from zruncho's github.

# Macro Status
Beta. Multi-tool printing currently fully working.
TODO:
1. Crash Detection

# Instructions
Coming soon. The files contain comments that you may follow. Or ask in discord.

# Files
1. btc.cfg <- Main file, required
2. btc_variables.cfg <- Variables, required
3. tool_x.cfg <- Individual tool settings, required
4. bashed_macros.cfg <- For stress testing of toolchanger, required after set up
5. btc_nudge.cfg <- Macros for nudge tool, required during set up
6. btc_klicky <- Required if using klicky probe
7. btc_extras <- Sample macros to use in start/end print
8. leds_x.cfg <- Required if using led effect