#! /bin/bash
#Scripted by Sark Xing

read -p "你确定要安装欧路词典吗？[Y/N]" -n 1 -r
echo    # (optional) move to a new line

PLISTURL="https://github.com/sarkrui/Eudic-for-Mac/raw/master/com.eusoft.eudic.plist"
LINKURL="https://github.com/sarkrui/Eudic-for-Mac/raw/master/links_cn.txt"
BREWURL="https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh"
PASSWORD=$(osascript -e 'display dialog "请输入你的解锁密码:" default answer "" with title "替换和锁定 com.eusoft.eudic 文件需要最高操作权限" with icon note buttons {"Cancel", "Continue"} default button "Continue"
set the VAL to text returned of the result
return VAL')

if [[ $REPLY =~ ^[Yy]$ ]]
then


	if [[ -d ~/Downloads/Eudic ]]; then
		#Uninstall previous Eudic.app and restore preferences
		echo "正在卸载旧版欧路词典..."
		rm -r ~/Downloads/Eudic
		mkdir ~/Downloads/Eudic && cd  ~/Downloads/Eudic

	else
		mkdir ~/Downloads/Eudic && cd  ~/Downloads/Eudic
	fi

	# Check if brew installed
	which -s brew
	if [[ $? != 0 ]] ; then
	    # Install Homebrew
		echo "正在安装 Homebrew..."
	    ruby -e "$(curl -fsSL $BREWURL)"
	fi

	#Check if wget installed
	echo "正在更新依赖..."
	which -s wget
	if [[ $? != 0 ]] ; then
	    # Install Homebrew
	    echo "正在安装 wget"
	    brew install wget
	else
		echo "wget 安装完成"
	fi

	# 下载 plist 文件
	wget -q --show-progress --no-check-certificate $PLISTURL
	wget -q --show-progress --no-check-certificate -O links.txt $LINKURL 

	# 下载切片文件
	echo "正在下载词典文件..."
	mkdir splits && wget -q --show-progress --no-check-certificate -i links.txt -P splits 


	# 组合欧路词典程序
	cat splits/eudicmac_3.8.2.dmga* > eudicmac_3.8.2.dmg 
	hdiutil attach eudicmac_3.8.2.dmg -quiet -noverify -noautoopen -nobrowse 2> /dev/null

	if [[ -d /Applications/Eudic.app ]] || [[ -d /Applications/Eudic_en.app ]]; then
		echo "$PASSWORD" | sudo -S chflags nouchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
		echo "$PASSWORD" | sudo -S rm ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
		echo "$PASSWORD" | sudo -S rm ~/Library/Cookies/com.eusoft.eudic.LightPeek.binarycookies 2> /dev/null
		echo "$PASSWORD" | sudo -S rm ~/Library/Cookies/com.eusoft.eudic.binarycookies 2> /dev/null
		echo "$PASSWORD" | sudo -S rm -r ~/Library/Saved\ Application\ State/com.eusoft.eudic.savedState 2> /dev/null
		echo "$PASSWORD" | sudo -S rm -r ~/Library/Caches/com.eusoft.eudic 2> /dev/null
		echo "$PASSWORD" | sudo -S rm -r ~/Library/Application\ Support/com.eusoft.eudic 2> /dev/null		
	fi

	# 安装和替换文件
	echo "Installing Eudic..."
	cp -R /Volumes/Eudic\ 欧路词典/Eudic.app /Applications/ 2> /dev/null
	echo "$PASSWORD" | sudo -S chflags nouchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	echo "$PASSWORD" | sudo -S rm ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	echo "$PASSWORD" | sudo -S cp com.eusoft.eudic.plist ~/Library/Preferences/
	echo "$PASSWORD" | sudo -S chflags uchg ~/Library/Preferences/com.eusoft.eudic.plist

	# 组合牛津辞典文件
	echo "安装词典文件..."
	cat splits/Oxford_mdict.zipa* > Oxford_mdict.zip
	unzip Oxford_mdict.zip
	echo "$PASSWORD" | sudo -S cp Oxford_mdict/O8C.* ~/Library/Eudb_en/

	#卸载安装文件
	while true; do
		read -p "你想要卸载安装文件吗？(Y/N)" yn
		case $yn in
	    	[Yy]* ) 
				echo "正在卸载..."
				hdiutil detach /Volumes/Eudic\ 欧路词典 
				rm -R -f ~/Downloads/Eudic
			break;;
	    	[Nn]* ) 
				exit;;
	    	* ) echo "输入错误";;
		esac
	done

	Clear;
	echo "安装已完成!"

else 
	echo "安装已取消！"
fi