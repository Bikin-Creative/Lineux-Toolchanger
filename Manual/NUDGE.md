# Instructions

Edit `btc_nudge.cfg` as below:

```
[gcode_button nudge_sensor_pin]
pin: ^PG15
press_gcode:
release_gcode:
# Enter pin number your nudge tool is connected to. Leave the rest as is.
```

```
[gcode_macro _nudge_variables]
variable_nudge_resolution: 0.05      # Resolution should be between 0.01 - 0.1
variable_nudge_travel_speed: 100
# resolution must be between 0.01 - 0.1
# travel_speed, set at your usual travel speed
```

Save and restart firmware.

Home All

Z Tile/Quad Gantry

Home Z

Move nozzle to a position about center of probe, and about 3mm above probe

NUDGE_FIND_TOOL_OFFSETS

When done, retrieve all tools offsets from console as describe below:

