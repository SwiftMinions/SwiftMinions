#!/bin/bash

# colors
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

MainPath="Sources"

# 印出 cd 的過程
CdAndPrint() {
    printf "current path -> ${PWD}\n"
    printf "cd to '$1' folder...\n"
    cd $1 
    if [ $? != 0 ]; then
        printf "${RED}cd failure. ㄅㄅ\n"
        exit 1
    fi
    printf "current path -> ${PWD}\n"
}

# 取得 當前版本號
GetcurrentVersion() {
    CdAndPrint "../${MainPath}"

    # 找出標籤在第幾行
    regex="<key>CFBundleShortVersionString<\/key>$"
    line=`grep -n ${regex} Info.plist | cut -d ":" -f 1`
    # 行數加一
    let "line++"
    # 找出當前版本號
    currentVersion=`sed -n "${line}p" Info.plist | cut -d ">" -f 2 | cut -d "<" -f 1`
    printf "current verstion -> ${GREEN}${currentVersion}${NC}\n"
}

# 取得 新的版本號（input）
GetNewVersion() {
    read -p "please input new version : " newVersion
    printf "new version is: ${GREEN}${newVersion}${NC} ?\n"
    read -p "please press [y/n] : " response
    if [ "$response" != "y" ]; then
		echo "${RED}ㄅㄅ"
		exit 1
	fi
}

# error: xcode-select: error: tool 'xcodebuild' requires Xcode, but active developer directory '/Library/Developer/CommandLineTools' is a command line tools instance
# cf. https://github.com/nodejs/node-gyp/issues/569
Build() {
    CdAndPrint ".."
    printf "${GREEN}start xcodebuild...\n${NC}"
    xcodebuild \
        -project SwiftMinions.xcodeproj \
        -scheme SwiftMinions \
        -sdk iphonesimulator \
        -destination 'platform=iOS Simulator,name=iPhone 11 pro,OS=13.0' 
    if [ $? != 0 ]; then
		echo "${RED}xcodebuild fail!\nㄅㄅ"
		exit 1
	fi
        # test | xcpretty --simple --report html
        # open ~/Documents/myProject/OhSwifter/OhSwifter/build/reports/tests.html
}

# Gitflow relsease
StartRelease() {
    git checkout develop || exit $?
    git flow release start ${newVersion} || exit $?
}

# 修改 Info.plist
ReplaceInfoPlist() {
    CdAndPrint "${MainPath}"
    printf "replace ${GREEN}${currentVersion}${NC} -> ${GREEN}${newVersion}${NC}\n"
    plutil -replace CFBundleShortVersionString -string "${newVersion}" Info.plist
}

# 修改 .podspec
ReplacePodSpec() {
    CdAndPrint ".."
    origin="s.version          = \'[0-9\.]+\'"
    new="s.version          = '${newVersion}'"
    sed -i "" -E "s/${origin}/${new}/g" "SwiftMinions.podspec" || exit $?
}

# stage and commit
StageAndCommit() {
    git stage . || exit $?
    git commit -m "[ Add ] : Release v${newVersion}" || exit $?
}

# finish release
FinishRelease() {
    export GIT_MERGE_AUTOEDIT=no
    git flow release finish -m "" ${newVersion}
    unset GIT_MERGE_AUTOEDIT
    git checkout develop || exit $?
    git push origin --tags || exit $?
    git checkout master || exit $?
    git push origin --tags || exit $?
}

# pod lint & push
PodLintAndPush() {
    pod spec lint
    if [ $? != 0 ]; then
        printf "${RED}pod lint fail.\nㄅㄅ"
        exit 1
    fi

    pod trunk push
    if [ $? != 0 ]; then
        printf "${RED}pod trunk push.\nㄅㄅ"
        exit 1
    fi
}

GetcurrentVersion
GetNewVersion
Build
StartRelease
ReplaceInfoPlist
ReplacePodSpec
StageAndCommit
FinishRelease
PodLintAndPush