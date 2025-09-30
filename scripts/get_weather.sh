#!/bin/bash

# This script fetches the current weather icon and temperature from wttr.in

curl -s "wttr.in?format=%c+%t"
