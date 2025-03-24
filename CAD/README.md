# Overview

There are 2 toolhead systems currently available:

- Lineux_DB - based on Dragonburner with partcooling fan embedded into the toolhead
- Lineux One - Is a lighter, smaller toolhead. The partcooling fan is mounted on the carriage and is shared across all toolheads.

*Note:* the toolheads use different carriage systems and are not compatible with each other. 


## Lineux One
All cads released are based on a Vzbot 330 and expect a top mounted linear rail on X gantry and front/back belt routing. You might need to adapt the dock and carriage to yr own printers. Voron_2.4 and Voron Trident are supported too. You can also check usermods section for any other printers cad/stl that may have been contributed by the community if they are not available here. Pls also do check in discord for any mods/contributions by the community.

Designs, mechanism and bom do get updated as we progress. Do take note.

Inspired by Axial Flux toolchanger [jera-sea](https://github.com/jera-sea/MagSwitch-Toolchanger).


# Printed Parts
Ensure the printed parts are printed without any warping to ensure proper and perfectly aligned components during installation.

It is recommended to do a test print on a small part for fitting, material shrinkage and tolerance measurement before commiting to the full printed parts.

Recommended slicer settings are as follows (Props to Voron team):
```
Layer height: 0.2mm
Extrusion width: 0.4mm, forced
Infill pecentage: 40%
Infill type: Adaptive Cubic, grid, gyroid, honeycomb, triangle, or cubic
Wall count: 4
Solid top/bottom layers: 5
```

# Carriage
Refer to the printer carriage available or check under usermods section. Pls do check in discord as well.

# Toolhead
Toolheads doesn't have any part cooling fan. You will only need 1 5015 part cooling fan on the carriage instead.
The part cooling duct is fixed height, therfore you will need to have the same height hotends across all toolheads. 

# Docks
Inspired by Daksh Toolchanger [ankurv2k6](https://github.com/ankurv2k6/daksh-toolchanger-v2)

# Dockslide
Dockslide is an optional addon to recover back any build volume loss encountered when having a fixed dock location on the existing printer.

# Requirement
1. Carriage
2. Toolheads (Quantity depends on how many you require or may fit on yr printer. Minimum of 2 toolheads recomended)
3. Docks (1 dock per toolhead required)
4. Nudge (Required for tool nozzle offset calibration)

Join our [Discord](https://discord.gg/Xwqbjj4VjH) for any questions u may have. Let's go...
