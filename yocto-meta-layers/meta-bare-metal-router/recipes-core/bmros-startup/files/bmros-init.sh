#!/usr/bin/env bash
#
# /etc/init.d/bmros.sh
#
### BEGIN INIT INFO
# Provides:          bmros
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start the Python script at boot time
# Description:       Start the Python script at boot time using a SysV init script
### END INIT INFO

# Script name
SCRIPT_NAME="bmros"

# Path to the Python script
PYTHON_SCRIPT="/usr/lib/routershell/scripts/factory-startup.py"

# Path to the Python interpreter
PYTHON_BIN="/usr/bin/env python3"

# Log file
LOG_FILE="/var/log/bmros-startup.log"

# Process ID file
PID_FILE="/var/run/${SCRIPT_NAME}.pid"

# Factory Flag
FLAG_FILE_DIR="/var/flags"
FLAG_FILE_NAME="bmros.FACTORY_START"
FACTORY_START_FLAG="${FLAG_FILE_DIR}/${FLAG_FILE_NAME}"

start() {
    echo "Starting $SCRIPT_NAME..."

    # Check if factory start flag exists
    if [ -f "${FACTORY_START_FLAG}" ]; then
        echo "Initial or Factory Reset, starting $SCRIPT_NAME..."
    fi    

    # Check if the script is already running
    if [ -f $PID_FILE ]; then
        echo "$SCRIPT_NAME is already running."
    else
        echo "Entering RouterShell Wrapper Script"
        /usr/lib/routershell/router-shell.sh || exit 1

        # Start the Python script in the background
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
