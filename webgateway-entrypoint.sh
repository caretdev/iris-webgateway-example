#!/bin/bash

dir=$(dirname $0)
pushd $dir

touch CSP.ini
touch CSP.log

apacheUser=daemon

chmod 600 CSP.ini
chown $apacheUser CSP.ini
chmod 600 CSP.log
chown $apacheUser CSP.log

configName=${CONFIG_NAME-LOCAL}
host=${SERVER_HOST-localhost}
port=${SERVER_PORT-51773}
username=${USERNAME-CSPSystem}
password=${USERNAME-SYS}

# [SYSTEM]
./cvtcfg setparameter "CSP.ini" "[SYSTEM]" "System_Manager" "*.*.*.*"

# [SYSTEM_INDEX]
./cvtcfg setparameter "CSP.ini" "[SYSTEM_INDEX]" "$configName" "Enabled"

# [$configName]
./cvtcfg setparameter "CSP.ini" "[${configName}]" "Ip_Address" "$host"
./cvtcfg setparameter "CSP.ini" "[${configName}]" "TCP_Port" "$port"
./cvtcfg setparameter "CSP.ini" "[${configName}]" "Username" "$username"
./cvtcfg setparameter "CSP.ini" "[${configName}]" "Password" "$password"

# [APP_PATH_INDEX]
./cvtcfg setparameter "CSP.ini" "[APP_PATH_INDEX]" "/" "Enabled"
./cvtcfg setparameter "CSP.ini" "[APP_PATH_INDEX]" "/csp" "Enabled"

# [APP_PATH:/]
./cvtcfg setparameter "CSP.ini" "[APP_PATH:/]" "Default_Server" "$configName"

# [APP_PATH:/csp]
./cvtcfg setparameter "CSP.ini" "[APP_PATH:/csp]" "Default_Server" "$configName"

popd

httpd-foreground