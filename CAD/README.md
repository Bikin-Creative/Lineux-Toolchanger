# Overview

There are 2 toolheads currently available:

- Lineux_DB - based on Dragonburner with partcooling fan embedded into the toolhead
- Lineux One - Is a lighter, smaller toolhead. The partcooling fan is mounted on the carriage and is shared across all toolheads.

Note: the toolheads use different carriage systems and are not compatible with each other.


## Lineux One
Lineux One is officially released and working.

All cads released are based on a Vzbot 330. You will need to adapt the dock and carriage to yr own printers.

Designs, mechanism and bom might changed as we progress. Do take note.

Inspired by Axial Flux toolchanger [jera-sea](https://github.com/jera-sea/MagSwitch-Toolchanger).


# Printed Parts
Ensure the printed parts are printed without any warping to ensure proper and perfectly aligned components during installation.

It is recommended to do a test print on a small part for fitting and tolerance measurement before commiting to the full printed parts.

Recommended settings are as follows:
```
First layer height: 0.25mm (This is required. Our parts have been designed for this.)
Layer height: 0.2mm
Extrusion width: 0.4mm, forced
Infill pecentage: 40%
Infill type: Adaptive Cubic, grid, gyroid, honeycomb, triangle, or cubic
Wall count: 4
Solid top/bottom layers: 5
Seam placement: REAR
This is important as we have seam relieve features that line up with the seam placement.
Supports: NONE
```

# Carriage
Current carriage is for VZBot. You may need to adapt the carriage to suit yr printer

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
