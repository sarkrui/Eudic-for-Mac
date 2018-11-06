#! /bin/bash
#Scripted by Sark Davidson

#Change working directory
cd "$(dirname "$0")"

#Uninstall previous Eudic.app and restore preferences
echo "Removing Eudic..."
sudo rm -r /Applications/Eudic.app
sudo rm -r /Applications/Eudb_en.app
sudo rm ~/Library/Preferences/com.eusoft.eudic.plist
sudo rm /Users/sarkdavidson/Library/Cookies/com.eusoft.eudic.LightPeek.binarycookies
sudo rm /Users/sarkdavidson/Library/Cookies/com.eusoft.eudic.binarycookies
sudo rm -r /Users/sarkdavidson/Library/Saved\ Application\ State/com.eusoft.eudic.savedState
sudo rm -r ~/Library/Caches/com.eusoft.eudic
sudo rm -r ~/Library/Application\ Support/com.eusoft.eudic

#Install Eudic and replace plist
echo "Installing Eudic..."
sudo cp com.eusoft.eudic.plist ~/Library/Preferences/com.eusoft.eudic.plist

echo "Done. Enjoy it!"