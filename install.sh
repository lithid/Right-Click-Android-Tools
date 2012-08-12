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
cp Lithid-Sign-Apk-Zip ${SCRIPT_DIR}/
cp sign.jar ${SCRIPT_DIR}/
echo "Sign-Apk-Zip is installed!
"
}

function_install_compress_sign() {
function_chk_script_dir
cp Lithid-Compress-Sign ${SCRIPT_DIR}/
echo "Compress-Sign is installed!
"
}

function_install_all() {
function_chk_script_dir
function_install_sign
function_install_compress_sign
}

function_help() {
echo "
Right click android tools installer
=====
Here are some things to do:
--install-sign <> Install sign-apk-zip script
--install-compressed-sign <> Install compress-sign script
--all <> Install all scripts
"
}

case $1 in
	--install-sign)function_install_sign; killall nautilus;;
	--install-compressed-sign)function_install_sign; killall nautilus;;
	--all)function_install_all; killall nautilus;;
	*)function_help;;
esac

exit 0
