#!/usr/bin/env bash
#title           : setvideo-1600x900.sh
#description     : Set resolution to second monitor
#author		     : MRP/mrp - Mauro Rosero P.
#personal email  : mauro.rosero@gmail.com
#notes           :
#==============================================================================
#
#==============================================================================

xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode "HDMI-A-0" "1600x900_60.00"
xrandr --output "HDMI-A-0" --mode "1600x900_60.00"
