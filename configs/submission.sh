#!/bin/bash

function CHECK_STAKE {
SUBMISSION_CHECK='50000'
IN='<<<'
OUT='>>>'
NANO='1000000000'
  n=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | wc -l) 
  for (( i = 1; i <= n; i++ ))
  do
  CHECK_IN_OUT=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | awk "FNR == ${i}" | awk '{print $4}' | sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g')
  CHECK_ELECTOR=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | awk "FNR == ${i}" | awk '{print $6}')
  STAKE=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | awk "FNR == ${i}" | awk '{print $5}'); STAKE=${STAKE%.*}
    if [ "$CHECK_ELECTOR" = "$ELECTOR" ] && [ "$CHECK_IN_OUT" = "$OUT" ] && [ "$STAKE" -gt "$SUBMISSION_CHECK" ]; then
         STAKE=$((STAKE * NANO))
         CHECK_ELECTION_SUBMISSION=$STAKE
         echo $CHECK_ELECTION_SUBMISSION
    fi
  done
}

ELECTOR='Ef8zMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzM0vF'
CONFIRM_AMOUNT='1.0'

mytonctrl <<< "vas validator_wallet_001" > ~/node.operator.nt/logs/vas_validator_wallet_001
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep "minutes ago" > ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "an hour ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "2 hours ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "3 hours ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "4 hours ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "5 hours ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "6 hours ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "7 hours ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1
cat ~/node.operator.nt/logs/vas_validator_wallet_001 | grep -w "8 hours ago" >> ~/node.operator.nt/logs/vas_validator_wallet_001_1

IN='<<<'
OUT='>>>'
n=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | wc -l) 

for (( i = 1; i <= n; i++ ))
do
CHECK_IN_OUT=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | awk "FNR == ${i}" | awk '{print $4}' | sed -r 's/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g')
CHECK_ELECTOR=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | awk "FNR == ${i}" | awk '{print $6}')
TX_AMOUNT=$(cat ~/node.operator.nt/logs/vas_validator_wallet_001_1 | awk "FNR == ${i}" | awk '{print $5}')

if [ "$CHECK_ELECTOR" = "$ELECTOR" ] && [ "$CHECK_IN_OUT" = "$IN" ] && [ "$TX_AMOUNT" = "$CONFIRM_AMOUNT" ]; then
     STAKE_SUBMITTED=1
  else
  :
fi
done

if [ "$STAKE_SUBMITTED" == 1 ]; then
CHECK_STAKE
fi
