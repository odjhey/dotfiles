#!/bin/sh
FOCUSED=$(yabai -m query --windows | jq -c ".[] | select(.focused| contains(1)) | .pid")
WINDOWS=$(yabai -m query --windows | jq -c ".[] | select(.pid| contains("$FOCUSED")) | .id")

yabai -m query --windows | jq -c ".[] | select(.focused| contains(1)) | {app: .app, id: .id}"
echo $FOCUSED
echo $WINDOWS

NEXT=$(echo $WINDOWS | cut -f2 -d' ')
echo $NEXT

yabai -m window --focus $NEXT
