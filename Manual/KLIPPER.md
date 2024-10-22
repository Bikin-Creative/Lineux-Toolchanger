 1. Create new folder btc in config folder.
 2. Copy files into btc folder.
 3. Edit tool_0.cfg. Change all relevant sections pertaining to the toolhead/board.
 4. Edit tool_x.cfg as per step 3.
 5. Optional, add more cfg for additional toolhead. For each additional toolhead, edit btc.cfg to include the new tool_x.cfg files.
 6. Firmware restart to verify all cfg are valid. Fix any error/s found before proceeding further.
 7. Edit all tool_x.cfg to set the approach position for x axis. Do this for both pickup and dropoff positions.
 8. Edit btc.cfg to set the following:
    1. Pickup move Y
    2. Pickup move X
    3. Dropoff move Y
    4. Dropoff move X
    5. Travel speed

       All moves are actual move in mm, not coordinate locations. Negative numbers accepted.
 9. Firmware restart to verify all cfg are valid. Fix any error/s found before proceeding further.
10. Use Check_Carriagesense_Tool and Check_Docksense_Tool buttons to test system senses. Go thru every toolhead. Make sure every toolhead report its location correctly.
    1. Put tool 0 to dock.
    2. Click Check_Carriagesense_Tool dropdown and enter 0.
    3. Make sure it returns Tool is not at carriage.
    4. Click Check_Docksense_Tool dropdown and enter 0.
    5. Make sure it returns Tool is at dock.
    6. Now put tool at carriage and repeat the test. Make sure the test reports Tool is at carriage and Tool is not at dock.
    7. Do this test for all tools.
11. DO NOT proceed further if any tool fail the above test.
12. tbc
