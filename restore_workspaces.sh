#!/bin/bash
# restore_workspaces.sh
# This script reorders windows for specific apps back to their designated workspaces
# using the AeroSpace CLI and jq.

# Ensure that jq is installed (use: brew install jq)

# Array of target app names, corresponding to the "app-name" in aerospace list output.
apps=("Books" "Discord" "Finder" "Mail" "Music" "Obsidian" "VLC" "Zed" "Zen" "Calendar" "Reminders")
# Their corresponding workspace names; adjust them if needed.
workspaces=("Books" "Discord" "Finder" "Mail" "Music" "Obsidian" "VLC" "Zed" "Zen" "CalRem" "CalRem")

# Number of apps in our arrays.
n=${#apps[@]}

for (( i=0; i < n; i++ )); do
  app="${apps[$i]}"
  workspace="${workspaces[$i]}"

  # Extract the window-id for the given app from the JSON output.
  window_id=$(aerospace list-windows --all --json | jq -r --arg app "$app" '.[] | select(.["app-name"] == $app) | .["window-id"]' | head -n1)

  if [ -n "$window_id" ] && [ "$window_id" != "null" ]; then
    echo "Moving window $window_id ($app) to workspace $workspace"

    aerospace move-node-to-workspace "$workspace" --window-id "$window_id"
  else
    echo "No window found for app '$app'"
  fi
done
