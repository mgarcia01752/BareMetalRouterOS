SUMMARY = "Modify /etc/passwd to start router-shell.sh upon login"
DESCRIPTION = "This script modifies the /etc/passwd file to change the root user's shell to first-login-check.sh."
LICENSE = "CLOSED"

# Adding the function to ROOTFS_POSTPROCESS_COMMAND ensures it runs after the root filesystem is created
ROOTFS_POSTPROCESS_COMMAND += "update_passwd_start_script;"

# Function to update /etc/passwd to set the root user's shell to router-shell.sh
update_passwd_start_script () {
    if [ -f ${IMAGE_ROOTFS}/etc/passwd ]; then
        sed -i '/^root:/ s#/bin/sh#/usr/lib/routershell/scripts/first-login-check.sh#' ${IMAGE_ROOTFS}/etc/passwd
    else
        echo "/etc/passwd not found in ${IMAGE_ROOTFS}"
    fi
}
