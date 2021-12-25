import socket
import telegram
import subprocess
import psutil
import time
from time import sleep
import commands
from datetime import datetime
from random import randint

sleep(randint(1,30))

my_token = '1503237112:AAGQMIrsK_dJpmrp7ulET4g1b15E6rcXs5g'
bot = telegram.Bot(token = my_token)
HOSTNAME = subprocess.check_output("tail -n 1 ~/serverno",shell=True)

ENGINE=commands.getoutput('~/node.operator.nt/monitor/checkEngine.sh')
if len(ENGINE) ==0:
  bot.sendMessage(chat_id='-1001685894260', text=str(HOSTNAME)+" ENGINE off");
  exit()

VALIDATION = subprocess.check_output("tail -n 1 ~/node.operator.nt/logs/election.log | grep -oP '(?<=VALIDATION_STATUS: )[0-9]'",shell=True);
ELECTION = subprocess.check_output("tail -n 1 ~/node.operator.nt/logs/election.log | grep -oP '(?<=ELECTION_STATUS: )[0-9]'",shell=True);
ERROR_TIME_UNIX = subprocess.check_output("tail -n 1 ~/node.operator.nt/logs/election.log | grep -oP '(?<=CURRENT_TIME).*' | awk '{print $2}' | tr -d ';'",shell=True);
SYNC=subprocess.check_output("~/node.operator.nt/scripts/checkSync.sh| grep TIME_DIFF | awk '{print $4}' | tr '[:upper:]' '[:lower:]'",shell=True);
DISKSPACE = subprocess.check_output("tail -n 1 ~/node.operator.nt/logs/election.log | awk '{print $12}'| tr -d ';'",shell=True);

ERROR_TIME = datetime.utcfromtimestamp(int(ERROR_TIME_UNIX)).strftime('%Y-%m-%d %H:%M:%S')
SYNCalarm = "-100"
SYNCalarm1 = 0
DISKalarm = 80

if int(VALIDATION) == 0:
  bot.sendMessage(chat_id='-1001685894260', text=str(HOSTNAME)+" Not Validating "+str(ERROR_TIME));
if int(ELECTION) == 0:
  bot.sendMessage(chat_id='-1001225148721', text=str(HOSTNAME)+" Not in Election "+str(ERROR_TIME));
if int(SYNC) < int(SYNCalarm):
  bot.sendMessage(chat_id='-1001685894260', text=str(HOSTNAME)+" SYNC off, SYNC:"+str(SYNC));
if int(SYNC) > int(SYNCalarm1):
  bot.sendMessage(chat_id='-1001685894260', text=str(HOSTNAME)+" SYNC off, SYNC:"+str(SYNC));
if int(DISKSPACE) > int(DISKalarm):
  bot.sendMessage(chat_id='-1001685894260', text=str(HOSTNAME)+" DISK SPACE FULL, DISK SPACE:"+str(DISKSPACE));

