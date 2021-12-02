#!/bin/bash
mytonctrl <<< "set stake 0" && mytonctrl <<< "ve"
sleep 20
BALANCE=$(mytonctrl <<< wl | grep validator_wallet_001 | awk '{print $3}')
BALANCE=${BALANCE%.*}
echo $BALANCE
RAN_DEDUCT=$[((RANDOM % 5)) + 3]
STAKE=$((BALANCE - RAN_DEDUCT))
echo $STAKE
mytonctrl <<< "set stake $STAKE"
mytonctrl <<< ve
mytonctrl <<< "set stake 0"
