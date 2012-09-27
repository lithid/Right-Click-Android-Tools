#!/bin/bash
# Installer script for right click tools.

HERE=$(pwd)

function_get_nautilus_version() {
VER="0"
CHK=$(nautilus --version |awk '{print $3}')
VER=$(echo $CHK |cut -d"." -f1)
}

function_chk_script_dir() {
function_get_nautilus_version
if [ ${VER} != "1" ] && [ ${VER} != "0" ]; then
	SCRIPT_DIR="$HOME/.gnome2/nautilus-scripts/Lithid"
else
	SCRIPT_DIR="$HOME/Nautilus/scripts/Lithid"
fi
if [ ! -d ${SCRIPT_DIR} ]; then
	mkdir -p ${SCRIPT_DIR}
fi
}

function_install_sign() {
function_chk_script_dir
cp Sign-Apk-Zip ${SCRIPT_DIR}/
cp sign.jar ${SCRIPT_DIR}/
echo ">>> Sign-Apk-Zip is installed! <<<"
}

function_install_compress_sign() {
function_chk_script_dir
cp Compress-Sign ${SCRIPT_DIR}/
echo ">>> Compress-Sign is installed! <<<"
}

function_install_apktool() {
function_chk_script_dir
cp -r Apktool/ ${SCRIPT_DIR}/
cd ${SCRIPT_DIR}/Apktool/
echo "Password needed to install apktool to /usr/local/bin"
sudo mv aapt apktool apktool.jar /usr/local/bin/
cd ${HERE}
echo ">>> Apktool is installed! <<<"
}

function_install_run_root() {
function_chk_script_dir
cp Run-As-Root ${SCRIPT_DIR}/
echo ">>> Run-As-Root is installed! <<<"
}

function_install_search_string() {
function_chk_script_dir
cp Search-For-String ${SCRIPT_DIR}/
echo ">>> Search-For-String is installed! <<<"
}

function_install_all() {
function_chk_script_dir
function_install_sign
function_install_compress_sign
function_install_apktool
function_install_run_root
function_install_search_string
}

function_help() {
echo "
Right click android tools installer
=====
Here are some things to do:
--install-sign <> Install sign-apk-zip script
--install-compressed-sign <> Install compress-sign script
--install-apktool <> Install apktool scripts
--install-runroot <> Install run as root
--install-searchstring <> Search for strings like grep
--all <> Install all scripts
"
}

case $1 in
	--install-sign)function_install_sign; killall nautilus;;
	--install-compressed-sign)function_install_compress_sign; killall nautilus;;
	--install-apktool)function_install_apktool; killall nautilus;;
	--install-runroot)function_install_run_root; killall nautilus;;
	--install-searchstring)function_install_search_string; killall nautilus;;
	--all)function_install_all; killall nautilus;;
	*)function_help;;
esac

exit 0
