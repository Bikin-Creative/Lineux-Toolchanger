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

# Instructions

With 1 or more tools installed and docked. Several values must be idnetified.

First, manually attach a tool to the carriage and home X/Y axis.
then jog the carriage and find out the `variable_tool_approachlocation_y`. 
This is a closes Y coordinate to the docks where the carriage can travel full length of X direction without hitting any docked tools.
Note this coordinate down and set it in `btc_variables.cfg`.

Then to carefuly and slowly manually jog the carraige to the dock of the current tool and make it dock. 
it is advisable to go slow in this step to ensure the dock does not get broken.

Once the tool is docked, note down the X,Y coordinates of the carriage and configure them in the tool_*.cfg file.

```
[gcode_macro _Variables_t0]
variable_docked_x: 000 # Set to th Dock X location for this tool
variable_docked_y: 000 # Set to the Dock Y location for this tool
```

Carefully jog the carriage in X direction to undock the tool, note the distance required for pins to fully leave the dock.
it should be about 12-13mm for Lineux One toolheads.

Set this value in `btc_variables.cfg`:

```
Variable_tool_lock_relative_x_move: 13
```