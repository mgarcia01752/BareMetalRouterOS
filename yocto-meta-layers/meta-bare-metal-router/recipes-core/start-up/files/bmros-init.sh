#!/usr/bin/env bash
#
# /etc/init.d/bmros.sh
#
### BEGIN INIT INFO
# Provides:          my_python_script
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start the Python script at boot time
# Description:       Start my Python script at boot time using a SysV init script
### END INIT INFO

# Script name
SCRIPT_NAME="routershell-startup"

# Path to the Python script
PYTHON_SCRIPT="/usr/lib/routershell/scripts/factory-startup.py"

# Path to the Python interpreter
PYTHON_BIN="/usr/bin/env python3"

# Log file
LOG_FILE="/var/log/bmros-startup.log"

# Process ID file
PID_FILE="/var/run/bmros.pid"

start() {
    echo "Starting $SCRIPT_NAME..."
    if [ -f $PID_FILE ]; then
        echo "$SCRIPT_NAME is already running."
    else
        nohup $PYTHON_BIN $PYTHON_SCRIPT >> $LOG_FILE 2>&1 &
        echo $! > $PID_FILE
        echo "$SCRIPT_NAME started with PID $(cat $PID_FILE)."
    fi
}

stop() {
    echo "Stopping $SCRIPT_NAME..."
    if [ -f $PID_FILE ]; then
        kill $(cat $PID_FILE)
        rm $PID_FILE
        echo "$SCRIPT_NAME stopped."
    else
        echo "$SCRIPT_NAME is not running."
    fi
}

restart() {
    stop
    start
}

status() {
    if [ -f $PID_FILE ]; then
        echo "$SCRIPT_NAME is running with PID $(cat $PID_FILE)."
    else
        echo "$SCRIPT_NAME is not running."
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac

exit 0
