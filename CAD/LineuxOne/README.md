## Lineux One
Lineux One is officially released and working.

All cads released are based on a Vzbot 330 and expect a top mounted linear rail on X gantry and front/back belt routing. You might need to adapt the dock and carriage to yr own printers (Voron_2.4 and Trident are supported). 

Designs, mechanism and bom do get updated as we progress. Do take note.

Inspired by Axial Flux toolchanger [jera-sea](https://github.com/jera-sea/MagSwitch-Toolchanger).


# Printed Parts
Ensure the printed parts are printed without any warping to ensure proper and perfectly aligned components during installation.

It is recommended to do a test print on a small part for fitting and tolerance measurement before commiting to the full printed parts.

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
Current development is based primarily on VZBot printer. 
Files are also available for Voron2.4 and Voron Trident.

You may need to adapt the carriage to suit your printer. Feel free to ask for help and advice on our Discord server.

# Toolhead
Toolheads doesn't have any part cooling fan. You will only need 1 5015 part cooling fan on the carriage instead.
The part cooling duct is fixed height, therfore you will need to have the same height hotends across all toolheads. 

# Docks
Inspired by Daksh Toolchanger [ankurv2k6](https://github.com/ankurv2k6/daksh-toolchanger-v2)