. ~/node.operator.nt/configs/scripts.config

current_time=$(echo " CURRENT_TIME: ${CURRENT_UNIXTIME};")
election_start_time=$(echo " ELECTION_START_TIME: ${CURRENT_ELECTION_SINCE_UNIXTIME};")
election_end_time=$(echo " ELECTION_END_TIME: ${CURRENT_ELECTION_UNTIL_UNIXTIME};")
sleep $(( RANDOM % 600))
if [ ${CURRENT_UNIXTIME} -gt $((${CURRENT_ELECTION_SINCE_UNIXTIME} + 1200)) -a ${CURRENT_UNIXTIME} -lt ${CURRENT_ELECTION_UNTIL_UNIXTIME} ]; then
    if ~/node.operator.nt/scripts/myElection.sh | grep -q 'SUBMISSION CONFIRMED'; then
        exit
    else
        if ~/node.operator.nt/scripts/myElection.sh | grep -q 'ELECTED VALIDATOR'; then
            exit
        else
            ~/node.operator.nt/scripts/participate.sh
        fi
    fi
fi
