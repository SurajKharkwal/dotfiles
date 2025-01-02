#!/bin/bash

# Function to start AGS
run() {
  ags run &
}

# Function to quit AGS
quit() {
  ags quit
}

# Get the input argument
input=$1

# Check if the input is 1 to start AGS, otherwise quit it
if [[ $input == 1 ]]; then
  run
else
  quit
fi
