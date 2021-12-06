#!/bin/bash
. ~/node.operator.nt/configs/scripts.config
        mytonctrl <<< "set stake 0"
if [ ${CURRENT_UNIXTIME} -gt $((${CURRENT_ELECTION_SINCE_UNIXTIME} + 100)) -a ${CURRENT_UNIXTIME} -lt ${CURRENT_ELECTION_UNTIL_UNIXTIME} ]; then

    if ~/node.operator.nt/scripts/myElection.sh | grep -q 'SUBMISSION CONFIRMED'; then
        mytonctrl <<< "set stake 0"
        exit
    else
        if ~/node.operator.nt/scripts/myElection.sh | grep -q 'ELECTED VALIDATOR'; then
            mytonctrl <<< "set stake 0"
            exit
        else
            sleep $((RANDOM % 300))
            ~/node.operator.nt/scripts/participate.sh
        fi
    fi
fi

