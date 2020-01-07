#!/usr/bin/env bash
# Dependencies: bash>=3.2, xfce4-power-manager, HeadsetControl
# https://github.com/Sapd/HeadsetControl

# Makes the script more portable
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Optional icons to display before the text
# Insert the absolute path of the icons
# Recommended size is 40x24 px
declare -ra ICON_ARRAY=(
  "${DIR}/icons/hs-battery/HS-unknown.png"     # unknown state
  "${DIR}/icons/hs-battery/HS0.png"            # less than 10%
  "${DIR}/icons/hs-battery/HS10.png"           # 10%
  "${DIR}/icons/hs-battery/HS20.png"           # 20%
  "${DIR}/icons/hs-battery/HS30.png"           # 30%
  "${DIR}/icons/hs-battery/HS40.png"           # 40%
  "${DIR}/icons/hs-battery/HS50.png"           # 50%
  "${DIR}/icons/hs0battery/HS50.png"           # 60%
  "${DIR}/icons/hs-battery/HS70.png"           # 70%
  "${DIR}/icons/hs-battery/HS80.png"           # 80%
  "${DIR}/icons/hs-battery/HS90.png"           # 90%
  "${DIR}/icons/hs-battery/HS100.png"          # 100%
)

regex="([0-9]*)%$"
VOLUME_CHANGE="(101)"
BATTERY_LEVEL="$(HeadsetControl -b)"

INFO=
if [[ $BATTERY_LEVEL =~ $regex ]]; then
	if [ "${BASH_REMATCH[1]}" -lt 10 ] ; then
		INFO="<img>${ICON_ARRAY[1]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 10 ] && [ "${BASH_REMATCH[1]}" -lt 20 ]; then
		INFO="<img>${ICON_ARRAY[2]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 20 ] && [ "${BASH_REMATCH[1]}" -lt 30 ]; then
		INFO="<img>${ICON_ARRAY[3]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 30 ] && [ "${BASH_REMATCH[1]}" -lt 40 ]; then
		INFO="<img>${ICON_ARRAY[4]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 40 ] && [ "${BASH_REMATCH[1]}" -lt 50 ]; then
		INFO="<img>${ICON_ARRAY[5]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 50 ] && [ "${BASH_REMATCH[1]}" -lt 60 ]; then
		INFO="<img>${ICON_ARRAY[6]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 60 ] && [ "${BASH_REMATCH[1]}" -lt 70 ]; then
		INFO="<img>${ICON_ARRAY[7]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 70 ] && [ "${BASH_REMATCH[1]}" -lt 80 ]; then
		INFO="<img>${ICON_ARRAY[8]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 80 ] && [ "${BASH_REMATCH[1]}" -lt 90 ]; then
		INFO="<img>${ICON_ARRAY[9]}</img>"
	elif [ "${BASH_REMATCH[1]}" -ge 90 ] && [ "${BASH_REMATCH[1]}" -lt 100 ]; then
		INFO="<img>${ICON_ARRAY[10]}</img>"
	elif [ "${BASH_REMATCH[1]}" -eq 90 ]; then
		INFO="<img>${ICON_ARRAY[11]}</img>"
	fi
    STATUS="${BASH_REMATCH}"
elif [[ $BATTERY_LEVEL =~ $VOLUME_CHANGE ]]; then
	INFO="<img>${ICON_ARRAY[0]}</img>"
 	STATUS="???%"
else	
 	STATUS="Disconnected"
fi

# Panel
INFO+="<txt>"
INFO+="<span weight='Regular' fgcolor='White'>"
INFO+="${STATUS}"
INFO+="</span>"
INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="${BATTERY_LEVEL}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
