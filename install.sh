#!/bin/bash
# Installer script for right click tools.

function_get_nautilus_version() {
VER="0"
CHK=$(nautilus --version |awk '{print $3}')
VER=$(echo $CHK |cut -d"." -f1)
}

function_chk_script_dir() {
function_get_nautilus_version
if [ ${VER} != "1" ] && [ ${VER} != "0" ]; then
	SCRIPT_DIR="$HOME/.gnome2/nautilus-scripts"
else
	SCRIPT_DIR="$HOME/Nautilus/scripts"
fi
if [ ! -d ${SCRIPT_DIR} ]; then
	mkdir -p ${SCRIPT_DIR}
fi
}

function_install_sign() {
function_chk_script_dir
cp Sign-Apk-Zip ${SCRIPT_DIR}/
cp sign.jar ${SCRIPT_DIR}/
killall nautilus
}

function_help() {
echo "
Right click android tools installer
=====
Here are some things to do:
--install-sign <> Install sign-apk-zip script
"
}

case $1 in
	--install-sign)function_install_sign;;
	*)function_help;;
esac

exit 0
