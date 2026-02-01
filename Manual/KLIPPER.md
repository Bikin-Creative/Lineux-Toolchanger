 1. Create new folder btc in config folder.
 2. Copy files into btc folder.
 3. Edit tool_0.cfg. Change all relevant sections pertaining to the toolhead/board.
 4. Optional, add more cfg for additional toolhead. For each additional toolhead, edit btc_variables.cfg to include the new tool_x.cfg files.
 5. Edit tool_x.cfg as per step 3.
 6. Firmware restart to verify all cfg are valid. Fix any error/s found before proceeding further.
 7. Edit all tool_x.cfg to set the approach position for x axis. Do this for both pickup and dropoff positions.
 8. Edit tool_x.cfg to set the following:
    1. variable_pickup_approachlocation
    2. variable_pickup_moves
    3. variable_dropoff_approachlocation
    4. variable_dropoff_moves
    
       All moves are absolute move in mm.
 9. Firmware restart to verify all cfg are valid. Fix any error/s found before proceeding further.
10. Use ```Get_Tool_States``` buttons to test system senses. Go thru every toolhead. Make sure every toolhead report its location correctly.
    1. Put tool 0 to dock.
    2. Click ```Get_Tool_States```.
    3. Make sure it returns Tool 0: carriage:no dock:yes
    4. Now put tool at carriage and repeat the test. Make sure the test reports Tool 0: carriage:yes dock:no
    5. Do this test for all tools.
11. DO NOT proceed further if any tool fail the above test.
12. tbc
