#!/bin/bash
#获取当前版本Xcode的DVTPlugInCompatibilityUUID
UUID=$(defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID)
echo Xcode DVTPlugInCompatibilityUUID is $UUID
#遍历每一个Xcode插件，将UUID写入插件的兼容列表中
for MyPlugin in ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/*
do
    UUIDs=$(defaults read "$MyPlugin"/Contents/Info DVTPlugInCompatibilityUUIDs)
    if echo "${UUIDs[@]}" | grep -w "$UUID" &>/dev/null; then
        echo "UUIDs has contained the Xcode's UUID"
    else
        defaults write "$MyPlugin"/Contents/Info DVTPlugInCompatibilityUUIDs -array-add $UUID
        echo write DVTPlugInCompatibilityUUID to $MyPlugin succeed!
    fi
done
echo "Done!"
