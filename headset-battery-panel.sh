#!/usr/bin/env bash
# Dependencies: bash>=3.2, xfce4-power-manager, HeadsetControl
# https://github.com/Sapd/HeadsetControl

regex="([0-9]*)%$"
BATTERY_LEVEL="$(HeadsetControl -b)"

if [[ $BATTERY_LEVEL =~ $regex ]]
then
    STATUS="${BASH_REMATCH}"
else
    STATUS="Disconnected"
fi

# Panel
INFO="<txt>"
INFO+="<span weight='Regular' fgcolor='White'>"
INFO+="${STATUS}"
INFO+="</span>"
INFO+="</txt>"

# Panel Print
echo -e "${INFO}"
