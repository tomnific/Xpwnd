# !/bin/bash


XCODE_PATH="/Applications/Xcode.app"
XPWND_PATH="/Applications/Xpwnd.app"




# Copy Xcode to Xpwnd
echo "Copying Xcode to Xpwnd..."
cp -a $XCODE_PATH/. $XPWND_PATH

if [ $? != 0 ]; then
	echo -ne "ERROR: Failed to copy Xcode to Xpwnd. \n   Please check that /Applications/Xcode.app exists and that /Applications/Xpwnd.app does not.\n"
	exit
fi 
echo "Done."




# Make user the owner
echo "Taking ownership of /Applications/Xpwnd.app..."
sudo chown -R $USER:everyone $XPWND_PATH

if [ $? != 0 ]; then
	echo "ERROR: Could not take ownership of Xpwnd."
	exit
fi
echo "Done."




# Rename executable
echo "Renaming executable to Xpwnd..."
mv $XPWND_PATH/Contents/MacOS/Xcode $XPWND_PATH/Contents/MacOS/Xpwnd

if [ $? != 0 ]; then
	echo "ERROR: Could not rename executable."
	exit
fi
echo "Done."




# Patch Info.plist
echo "Patching Info.plist..."
plutil -replace "CFBundleIconFile" -string "Xpwnd" $XPWND_PATH/Contents/Info.plist 
plutil -replace "CFBundleName" -string "Xpwnd" $XPWND_PATH/Contents/Info.plist 
plutil -replace "CFBundleIdentifier" -string "com.tomawesome.dt.Xpwnd" $XPWND_PATH/Contents/Info.plist 
plutil -replace "CFBundleExecutable" -string "Xpwnd" $XPWND_PATH/Contents/Info.plist 

if [ $? != 0 ]; then
	echo "ERROR: Could not patch Info.plist."
	exit
fi
echo "Done."




# Patch the bundle name
echo "Patching InfoPlist.strings..."
LANG=C sed -i '.bak' 's/CFBundleName/Xpwnd/g' $XPWND_PATH/Contents/Resources/English.lproj/InfoPlist.strings

if [ $? != 0 ]; then
	echo "ERROR: Could not patch InfoPlist.strings."
	exit
fi
echo "Done."




# Patch Assets.car 
echo "Patching Assets.car..."
cp ./resources/Assets.car $XPWND_PATH/Contents/Resources/Assets.car 

if [ $? != 0 ]; then
	echo "ERROR: Could not patch Assets.car."
	exit
fi
echo "Done."




# Patch App Icon 
echo "Patching App Icon..."
cp ./resources/Xpwnd.icns $XPWND_PATH/Contents/Resources/Xpwnd.icns
rm $XPWND_PATH/Contents/Resources/Xcode.icns

if [ $? != 0 ]; then
	echo "ERROR: Could not patch App Icon."
	exit
fi
echo "Done."




# Patch IDEWelcomeWindow.nib
echo "Patching IDEWelcomeWindow.nib...."
cp ./resources/IDEKit/IDEWelcomeWindow.nib $XPWND_PATH/Contents/Frameworks/IDEKit.framework/Versions/A/Resources/IDEWelcomeWindow.nib

if [ $? != 0 ]; then
	echo "ERROR: Could not patch IDEWelcomeWindow.nib."
	exit
fi
echo "Done."




# TODO: I think we're missing like xpwndproj_Icon.icns, etc
echo -e "\nXpwnd initialization complete.\n"
echo -e "Beginning Full Transformation To Xpwnd.\n\n"




# Create iPhoneJailbreak Platform
echo "Making iPhoneJailbreak Platform...."
cp -r $XPWND_PATH/Contents/Developer/Platforms/iPhoneOS.platform $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform
if [ $? != 0 ]; then
	echo "ERROR: Could not make iPhoneJailbreak Platform."
	exit
fi
echo "Done."


# Patch iPhoneJailbreak Platform
echo "Patching iPhoneJailbreak Platform...."
cp ./resources/Platforms/iPhoneJailbreak/Info.plist $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Info.plist
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneJailbreak Platform."
	exit
fi

cp ./resources/Platforms/iPhoneJailbreak/Developer/Library/Xcode/PrivatePlugIns/IDEiOSPlatformSupportCore.xcplugindata $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/Library/Xcode/PrivatePlugIns/IDEiOSPlatformSupportCore.ideplugin/Contents/Resources/IDEiOSPlatformSupportCore.xcplugindata
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneJailbreak Platform."
	exit
fi

cp -r ./resources/Platforms/iPhoneJailbreak/Developer/Library/Xcode/Templates/Project\ Templates $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/Library/Xcode/Templates/Project\ Templates
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneJailbreak Platform."
	exit
fi
echo "Done."




# Create iPhoneSecurity Platform
echo "Making iPhoneSecurity Platform...."
cp -r $XPWND_PATH/Contents/Developer/Platforms/iPhoneOS.platform $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform

if [ $? != 0 ]; then
	echo "ERROR: Could not make iPhoneSecurity Platform."
	exit
fi
echo "Done."




# Patch iPhoneJailbreak Platform
echo "Patching iPhoneSecurity Platform...."
cp ./resources/Platforms/iPhoneSecurity/Info.plist $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Info.plist
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneSecurity Platform."
	exit
fi

cp ./resources/Platforms/iPhoneSecurity/Developer/Library/Xcode/PrivatePlugIns/IDEiOSPlatformSupportCore.xcplugindata $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/Library/Xcode/PrivatePlugIns/IDEiOSPlatformSupportCore.ideplugin/Contents/Resources/IDEiOSPlatformSupportCore.xcplugindata
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneSecurity Platform."
	exit
fi

cp -r ./resources/Platforms/iPhoneSecurity/Developer/Library/Xcode/Templates/Project\ Templates $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/Library/Xcode/Templates/Project\ Templates
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneSecurity Platform."
	exit
fi
echo "Done."




# Remove Other Platforms (tvOS, watchOS, tv simulator, watch simulator
echo "Removing unnecessary platforms..."
rm -rf $XPWND_PATH/Contents/Developer/Platforms/AppleTVOS.platform 
if [ $? != 0 ]; then
	echo "ERROR: Could not remove AppleTVOS Platform."
	exit
fi

rm -rf $XPWND_PATH/Contents/Developer/Platforms/AppleTVSimulator.platform 
if [ $? != 0 ]; then
	echo "ERROR: Could not remove AppleTVSimulator Platform."
	exit
fi

rm -rf $XPWND_PATH/Contents/Developer/Platforms/WatchOS.platform 
if [ $? != 0 ]; then
	echo "ERROR: Could not remove WatchOS Platform."
	exit
fi

rm -rf $XPWND_PATH/Contents/Developer/Platforms/WatchSimulator.platform 
if [ $? != 0 ]; then
	echo "ERROR: Could not remove WatchSimulator Platform."
	exit
fi
echo "Done."




# Create iPhoneOS.Jailbreak SDK
echo "Making iPhoneOS.Jailbreak SDK..."
mv $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/SDKs/iPhoneOS.sdk $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/SDKs/iPhoneOS.Jailbreak.sdk

if [ $? != 0 ]; then
	echo "ERROR: Could not make iPhoneOS.Jailbreak SDK."
	exit
fi


find $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/SDKs/ -name 'iPhoneOS[1-9]*.[1-9]*.sdk' -delete

if [ $? != 0 ]; then
	echo "ERROR: Could remove version-specific symlink to iPhoneOS.sdk."
	exit
fi
echo "Done."




# Patch iPhoneOS.Jailbreak SDK
echo "Patching iPhoneOS.Jailbreak SDK..."
cp ./resources/SDKs/iPhoneOS.Jailbreak/SDKSettings.plist $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/SDKs/iPhoneOS.Jailbreak.sdk/SDKSettings.plist
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneOS.Jailbreak SDK."
	exit
fi

cp -R ./resources/SDKs/iPhoneOS.Jailbreak/usr/lib/. $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/SDKs/iPhoneOS.Jailbreak.sdk/usr/lib/
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneOS.Jailbreak SDK."
	exit
fi

rm -r $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/SDKs/iPhoneOS.Jailbreak.sdk/System/Library/Frameworks/IOKit.framework
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneOS.Jailbreak SDK."
	exit
fi

cp -r ./resources/SDKs/iPhoneOS.Jailbreak/System/Library/Frameworks/IOKit.framework $XPWND_PATH/Contents/Developer/Platforms/iPhoneJailbreak.platform/Developer/SDKs/iPhoneOS.Jailbreak.sdk/System/Library/Frameworks/IOKit.framework
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneOS.Jailbreak SDK."
	exit
fi
echo "Done."




# Create iPhoneOS.SecurityResearch SDK
echo "Making iPhoneOS.SecurityResearch SDK..."
mv $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/SDKs/iPhoneOS.sdk $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/SDKs/iPhoneOS.SecurityResearch.sdk

if [ $? != 0 ]; then
	echo "ERROR: Could not make iPhoneOS.SecurityResearch SDK."
	exit
fi


find $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/SDKs/ -name 'iPhoneOS[1-9]*.[1-9]*.sdk' -delete

if [ $? != 0 ]; then
	echo "ERROR: Could remove version-specific symlink to iPhoneOS.sdk."
	exit
fi
echo "Done."




# Patch iPhoneOS.SecurityResearch SDK
echo "Patching iPhoneOS.SecurityResearch SDK..."
cp ./resources/SDKs/iPhoneOS.SecurityResearch/SDKSettings.plist $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/SDKs/iPhoneOS.SecurityResearch.sdk/SDKSettings.plist
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneOS.SecurityResearch SDK."
	exit
fi

rm -r $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/SDKs/iPhoneOS.SecurityResearch.sdk/System/Library/Frameworks/IOKit.framework
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneOS.SecurityResearch SDK."
	exit
fi

cp -r ./resources/SDKs/iPhoneOS.SecurityResearch/System/Library/Frameworks/IOKit.framework $XPWND_PATH/Contents/Developer/Platforms/iPhoneSecurity.platform/Developer/SDKs/iPhoneOS.SecurityResearch.sdk/System/Library/Frameworks/IOKit.framework
if [ $? != 0 ]; then
	echo "ERROR: Could not patch iPhoneOS.SecurityResearch SDK."
	exit
fi
echo "Done."




# Add iPhoneOS.Jailbreak Sparse SDK
echo "Adding iPhoneOS.Jailbreak Sparse SDK..."
cp -r ./resources/SDKs/Sparse/iPhoneOS.Jailbreak.Sparse.sdk $XPWND_PATH/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.Jailbreak.Sparse.sdk

if [ $? != 0 ]; then
	echo "ERROR: Could not add iPhoneOS.SecurityResearch SDK."
	exit
fi
echo "Done."




# Add iPhoneOS.SecurityResearch Sparse SDK
echo "Adding iPhoneOS.SecurityResearch Sparse SDK..."
cp -r ./resources/SDKs/Sparse/iPhoneOS.SecurityResearch.Sparse.sdk $XPWND_PATH/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.SecurityResearch.Sparse.sdk

if [ $? != 0 ]; then
	echo "ERROR: Could not add iPhoneOS.SecurityResearch SDK."
	exit
fi
echo "Done."




# Clean up
echo "Cleaning up..."
rm -r $XPWND_PATH/Contents/_MASReceipt

if [ $? != 0 ]; then
	echo "ERROR: Could not remove Mac App Store Receipt. Continuing anyways..."
	echo "   If you downloaded Xcode from developer.apple.com, then you can ignore this error."
fi



# Remove Applications
echo "Removing unnecessary Applications..."
rm -r $XPWND_PATH/Contents/Applications

if [ $? != 0 ]; then
	echo "ERROR: Failed to remove applications."
fi
echo "Done."


# TODO: I think we're missing the xcspec or whatever it was that let us remove "iPhone" from the device list to stop device stealing
echo -e "\nXpwnd Transformation Complete.\n"
echo -e "Beginning Finalization.\n\n"




# Codesign Xpwnd
echo "Codesigning Xpwnd..."
(IFS='
'
for x in `security find-identity -v -p codesigning`; do
	if [[ $x == *"Developer"* ]]; then
		strip=${x:47}
		id=${strip%\"*}
		sudo codesign -fs "$id" $XPWND_PATH --deep
		break
	fi
done)

if [ $? != 0 ]; then
	echo "ERROR: Could not codesign Xpwnd."
	exit
fi
echo "Done."




# Make root the owner
echo "Returning ownership of /Applications/Xpwnd.app to root..."
sudo chown -R root:wheel $XPWND_PATH

if [ $? != 0 ]; then
	echo "ERROR: Could not return ownership of Xpwnd."
	exit
fi
echo "Done."




# Change default compiler to Xpwnd
echo "Making Xpwnd the default compiler..."
sudo xcode-select -switch $XPWND_PATH
if [ $? != 0 ]; then
	echo "ERROR: Could not make Xpwnd the default compiler."
	exit
fi
echo "done"
