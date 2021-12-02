#!/bin/bash
. ~/node.operator.nt/configs/scripts.config

if [ ${CURRENT_UNIXTIME} -gt $((${CURRENT_ELECTION_SINCE_UNIXTIME} + 1200)) -a ${CURRENT_UNIXTIME} -lt ${CURRENT_ELECTION_UNTIL_UNIXTIME} ]; then

    if ~/node.operator.nt/scripts/myElection.sh | grep -q 'SUBMISSION CONFIRMED'; then
        exit
    else
        if ~/node.operator.nt/scripts/myElection.sh | grep -q 'ELECTED VALIDATOR'; then
            exit
        else
            crontab -r
            sleep $((RANDOM % 300))
            ~/node.operator.nt/scripts/participate.sh
        fi
    fi
fi
sleep 5
crontab ~/node.operator.nt/configs/crontab.config
