#!/bin/bash

username=$(whoami)
hostname=$(hostname -s)

diskspace=$(df -k / | awk  'FNR == 2 {print $5}' | tr -d '%')
diskspace=$(echo " DISKSPACE: ${diskspace};")
. ~/node.operator.nt/configs/scripts.config

current_time=$(echo " CURRENT_TIME: ${CURRENT_UNIXTIME};")
election_start_time=$(echo " ELECTION_START_TIME: ${CURRENT_ELECTION_SINCE_UNIXTIME};")
election_end_time=$(echo " ELECTION_END_TIME: ${CURRENT_ELECTION_UNTIL_UNIXTIME};")

after_election_about_two_half=$((${CURRENT_UNIXTIME} - ${CURRENT_ELECTION_UNTIL_UNIXTIME}))

if ~/node.operator.nt/scripts/myElection.sh | grep -q 'CURRENTLY NOT VALIDATING'; then
		if [ ${after_election_about_two_half} -ge 0 ]; then
    		validation=$(echo "VALIDATION_STATUS: 1;")
			else
    		validation=$(echo "VALIDATION_STATUS: 0;")
		fi
else
    validation=$(echo "VALIDATION_STATUS: 1;")
fi

# Election start time ~ Election end time TRUE
if [ ${CURRENT_UNIXTIME} -gt $((${CURRENT_ELECTION_SINCE_UNIXTIME} + 3600)) -a ${CURRENT_UNIXTIME} -lt ${CURRENT_ELECTION_UNTIL_UNIXTIME} ]; then
    if ~/node.operator.nt/scripts/myElection.sh | grep -q 'SUBMISSION CONFIRMED'; then
        election=$(echo " ELECTION_STATUS: 1;")
    else
        if ~/node.operator.nt/scripts/myElection.sh | grep -q 'ELECTED VALIDATOR'; then
            election=$(echo " ELECTION_STATUS: 1;")
        else
            election=$(echo " ELECTION_STATUS: 0;")
        fi
    fi
else
    election=$(echo " ELECTION_STATUS: 2;")
fi

validation_condition=$(echo ${validation} | awk '{print $2}' | tr -d ';')
election_condition=$(echo ${election} | awk '{print $2}' | tr -d ';')

if [ ${validation_condition} -eq 0 -o ${election_condition} -eq 0 ]; then
    echo $validation $election $current_time >> ~/node.operator.nt/logs/election_err.log
fi

echo $validation $election $current_time $election_start_time $election_end_time $diskspace >> ~/node.operator.nt/logs/election.log
