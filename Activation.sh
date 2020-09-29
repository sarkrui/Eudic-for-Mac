#! /bin/bash
# Scripted by Sark Xing

# Uninstall previous Eudic.app and restore preferences

read -p "你确定要重新安装欧路词典吗？[Y/N]" -n 1 -r
PASSWORD=$(osascript -e 'display dialog "请输入你的解锁密码:" default answer "" with title "替换和锁定 com.eusoft.eudic 文件需要最高操作权限" with icon note buttons {"Cancel", "Continue"} default button "Continue"
set the VAL to text returned of the result
return VAL')
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "正在重新安装..."

	# Make a foler and change working directory to the new folder
	if [[ -d ~/Downloads/Eudic ]]; then
		#Uninstall previous Eudic.app and restore preferences
		echo "正在卸载旧版欧路词典..."
		rm -r ~/Downloads/Eudic
		mkdir ~/Downloads/Eudic && cd  ~/Downloads/Eudic

	else
		mkdir ~/Downloads/Eudic && cd  ~/Downloads/Eudic
	fi
	
	wget --no-check-certificate https://cdn.jsdelivr.net/gh/sarkrui/Eudic-for-Mac@master/com.eusoft.eudic.plist 2> /dev/null
	echo "$PASSWORD" | sudo -S chflags nouchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	echo "$PASSWORD" | sudo -S rm ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	echo "$PASSWORD" | sudo -S rm ~/Library/Cookies/com.eusoft.eudic.LightPeek.binarycookies 2> /dev/null
	echo "$PASSWORD" | sudo -S rm ~/Library/Cookies/com.eusoft.eudic.binarycookies 2> /dev/null
	echo "$PASSWORD" | sudo -S rm -r ~/Library/Saved\ Application\ State/com.eusoft.eudic.savedState 2> /dev/null
	echo "$PASSWORD" | sudo -S rm -r ~/Library/Caches/com.eusoft.eudic 2> /dev/null
	echo "$PASSWORD" | sudo -S rm -r ~/Library/Application\ Support/com.eusoft.eudic 2> /dev/null

	# Install Eudic and replace plist
	echo "$PASSWORD" | sudo -S mv com.eusoft.eudic.plist ~/Library/Preferences/ 2> /dev/null
	echo "$PASSWORD" | sudo -S chflags uchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null

	echo "已重新安装欧路词典！"
	echo "请重启您的 Mac！"
else 
	echo "安装已取消！"
fi