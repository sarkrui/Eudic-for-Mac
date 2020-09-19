#! /bin/bash
# Scripted by Sark Xing

# Uninstall previous Eudic.app and restore preferences

read -p "你确定要重新安装欧路词典吗？[Y/N]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "正在重新安装..."

	# Make a foler and change working directory to the new folder
	cd "$(dirname "$0")" && mkdir ~/Downloads/Eudic && cd  ~/Downloads/Eudic
	wget --no-check-certificate https://github.com/sarkrui/Eudic-for-Mac/raw/master/com.eusoft.eudic.plist
	sudo chflags nouchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	sudo rm ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	sudo rm ~/Library/Cookies/com.eusoft.eudic.LightPeek.binarycookies 2> /dev/null
	sudo rm ~/Library/Cookies/com.eusoft.eudic.binarycookies 2> /dev/null
	sudo rm -r ~/Library/Saved\ Application\ State/com.eusoft.eudic.savedState 2> /dev/null
	sudo rm -r ~/Library/Caches/com.eusoft.eudic 2> /dev/null
	sudo rm -r ~/Library/Application\ Support/com.eusoft.eudic 2> /dev/null

	# Install Eudic and replace plist
	sudo mv com.eusoft.eudic.plist ~/Library/Preferences/ 2> /dev/null
	sudo chflags uchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null

	echo "已重新安装欧路词典！"
	echo "请重启您的 Mac！"
else 
	echo "安装已取消！"
fi