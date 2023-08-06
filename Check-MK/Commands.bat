cd "C:\Program Files (x86)\checkmk\service"
check_mk_agent.exe updater register --hostname %1 --user %2 --password %3
check_mk_agent.exe updater
