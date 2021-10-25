
sudo apt install -y python && sudo apt update && sudo apt install -y python-pip && sudo pip install gspread && sudo python -m pip install oauth2client && sudo pip install psutil && pip uninstall python-telegram-bot; pip uninstall telegram; pip uninstall telegram-bot; pip install telegram-bot
echo "VALIDATION_STATUS: 2; ELECTION_STATUS: 2; CURRENT_TIME: 0; ELECTION_START_TIME: 0; ELECTION_END_TIME: 0;" > ~/node.operator/logs/election.log
