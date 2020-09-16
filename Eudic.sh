#! /bin/bash
#Scripted by Sark Xing

EUDICURL="https://github.com/sarkrui/Eudic-for-Mac/releases/download/1.1/eudicmac_3.8.2.dmg"
OXFORDURL="https://github.com/sarkrui/Eudic-for-Mac/releases/download/1.0.1/Oxford_mdict.zip"
PLISTURL="https://github.com/sarkrui/Eudic-for-Mac/raw/master/com.eusoft.eudic.plist"

read -p "你确定要安装欧路词典吗？[Y/N]" -n 1 -r
echo    # (optional) move to a new line
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
	    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		echo "正在更新 Homebrew..."	
	    brew update
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

	#Check if aria2 installed
	which -s aria2c
	if [[ $? != 0 ]] ; then
	    # Install Homebrew
	    echo "正在安装 aria2"
	    brew install aria2 
	fi

	wget -q --show-progress --no-check-certificate $PLISTURL
	aria2c --enable-rpc=false -c -x16 $EUDICURL
	hdiutil attach eudicmac_3.8.2.dmg -nobrowse 

	echo "请输入锁屏密码"
	echo "为什么需要输入密码？替换和锁定 com.eusoft.eudic 文件需要最高操作权限"
	echo "(输入时，密码不可见)"
	read -s password
	echo "密码为：$password"

	if [[ -d /Applications/Eudic.app ]] || [[ -d /Applications/Eudic_en.app ]]; then
	

		# Run Command
		echo "$password" | sudo chflags nouchg ~/Library/Preferences/com.eusoft.eudic.plist 

		echo "$password" | sudo chflags nouchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
		echo "$password" | sudo rm ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
		echo "$password" | sudo rm ~/Library/Cookies/com.eusoft.eudic.LightPeek.binarycookies 2> /dev/null
		echo "$password" | sudo rm ~/Library/Cookies/com.eusoft.eudic.binarycookies 2> /dev/null
		echo "$password" | sudo rm -r ~/Library/Saved\ Application\ State/com.eusoft.eudic.savedState 2> /dev/null
		echo "$password" | sudo rm -r ~/Library/Caches/com.eusoft.eudic 2> /dev/null
		echo "$password" | sudo rm -r ~/Library/Application\ Support/com.eusoft.eudic 2> /dev/null		
	fi

	#Install Eudic and replace plist
	echo "Installing Eudic..."
	cp -R /Volumes/Eudic\ 欧路词典/Eudic.app /Applications/ 2> /dev/null
	echo "$password" | sudo chflags nouchg ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	echo "$password" | sudo rm ~/Library/Preferences/com.eusoft.eudic.plist 2> /dev/null
	echo "$password" | sudo cp com.eusoft.eudic.plist ~/Library/Preferences/
	echo "$password" | sudo chflags uchg ~/Library/Preferences/com.eusoft.eudic.plist

	#下载牛津高阶词典
	while true; do
		read -p "你想要下载牛津高阶词典吗？(Y/N)" yn
		case $yn in
	    	[Yy]* ) 
				echo "正在下载词典文件..."
				aria2c --enable-rpc=false -c -x16 $OXFORDURL
				unzip Oxford_mdict.zip
				echo "安装词典文件..."
				sudo cp Oxford_mdict/O8C.* ~/Library/Eudb_en/
			break;;
	    	[Nn]* ) 
				exit;;
	    	* ) echo "输入错误";;
		esac
	done

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








