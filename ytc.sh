#!/bin/bash
# blackhat zone --- use it as u love 
# u need to read .json after u done it has a lot of info
# if u want to use value to play around BurpSuite it will help 
# sudo apt install notify-osd exiv2 imagemagick libimage-exiftool-perl jq 
# v1.1 
c(){
    
    if ! dpkg -s $1 >/dev/null 2>&1; then
        sudo apt install $1 -y
    else 
        echo "[ + ] $1 found"
        sleep 0.1
    fi
 
}
for COMMAND in "notify-osd" "exiv2" "imagemagick" "libimage-exiftool-perl" "jq"; do
    c "${COMMAND}"
done
clear
printf "
\e[38;5;120m\e[1;36m+++++\e[0m\e[38;5;31m\e[1;37m YouTube Information \e[38;5;120m\e[1;36m+++++\e[0m\n\n
[ \e[38;5;120m+\e[0m ]\e[38;5;31m\e[1;37m Target Url: \e[38;5;242m http://www.youtube.com/watch?v=watch?v=\e[38;5;31m\e[1;37mYpJRfruTQAc\e[0m
[ \e[38;5;120m+\e[0m ]\e[38;5;31m\e[1;37m watch-V id is : -> \e[38;5;120m\e[1;33mYpJRfruTQAc\e[0m\n\n"
read -p $'\e[38;5;120m\e[1;36m+++++\e[0m\e[38;5;31m\e[1;37m Enter now watch?v=\e[0m: ' YouTubeID
clear
if [ ! -d "output" ]; then mkdir output ; fi
YTD_outputSavee="output/$YouTubeID"
if [ ! -d "$YTD_outputSavee" ]; then mkdir $YTD_outputSavee ; fi
YTD_SAVE="$YTD_outputSavee"
YTD_channelLink=$(wget -qO- 'https://www.youtube.com/watch?v='$YouTubeID | grep -iPo '(?<=externalChannelId":")(.*)(?=","isFamilySafe)')
YTD_profile_image=$(wget -qO- "https://www.youtube.com/channel/$YTD_channelLink" | grep -iPo '(?<=<meta name="twitter:image" content=")(.*)(?="><meta name="twitter:app:name:iphone")')
T4T_CMD_SEND_IMAGE=$(wget -q $YTD_profile_image -O $YTD_SAVE/photo_$YouTubeID.jpg)
YTD_titleName=$(wget -qO- 'https://www.youtube.com/watch?v='$YouTubeID | grep -iPo '(?<=<title>)(.*)(?=- youtube</title>)')
YTD_UserName=$(wget -qO- "https://www.youtube.com/channel/$YTD_channelLink" | grep -iPo '(?<=<title>)(.*)(?=- youtube</title>)')
found=$(notify-send -u normal -t 6500 "Username" "$YTD_UserName" -i $pwd/icon/youtube.ico)
YTD_OwnerUrls=$(wget -qO- "https://www.youtube.com/channel/$YTD_channelLink" | grep -iPo '(?<=ownerUrls":..)(.*)(?="],"avatar)')
found=$(notify-send -u normal -t 6500 "Owner Url" "$YTD_OwnerUrls" -i $pwd/icon/h.png)
YTD_API_KEY=$(wget -qO- "https://www.youtube.com/channel/$YTD_channelLink" | grep -iPo '(?<=INNERTUBE_API_KEY...)(.*)(?=...INNERTUBE_API_VERSION)')
found=$(notify-send -u normal -t 6500 "Your APIKEY IN CASE " "$YTD_API_KEY" -i $pwd/icon/apikey.png)
YTD_Description=$(wget -qO- "https://www.youtube.com/channel/$YTD_channelLink" | grep -iPo '(?<=description..content..)(.*)(?=...meta.name="keywords")')
YTD_about_viewCount=$(wget -qO- "https://www.youtube.com/channel/$YTD_channelLink/about" | grep -iPo '(?<=viewCountText":{"simpleText":")(.*)(?="},"joinedDateText")')
pwd=$(pwd)
dix="$pwd/$YTD_SAVE/photo_$YouTubeID.jpg"
found=$(notify-send -u normal -t 12500 "Photo has been uploaded" "check his picture" -i $dix)
m1="DONE : [ ExifTool ]"
m2="DONE : [ Exiv2 ]"
m3="DONE : [ identify ]"
YTD_JSONFORMAT=$(wget -qO- "https://www.youtube.com/channel/$YTD_channelLink/about" | grep -iPo '(?<=var.ytInitialData.= {"responseContext":)(.*)(?=.}}.;)')
T4T_CMD_1=$(gnome-terminal -- bash -c "curl -s '$YTD_profile_image' | exiftool -fast - > $pwd/$YTD_SAVE/exiftool-$YouTubeID.txt; exit ; ${SHELL:-bash}")
found=$(notify-send -u normal -t 4200 "Tool : ExifTool" "has been scanned" -i $pwd/icon/sc.png)
T4T_CMD_2=$(gnome-terminal -- bash -c "curl -s '$YTD_profile_image' | exiv2 - > $pwd/$YTD_SAVE/exiv2-$YouTubeID.txt; exit ; ${SHELL:-bash}")
found=$(notify-send -u normal -t 5200 "Tool : Exiv2" "has been scanned" -i $pwd/icon/sc.png)
T4T_CMD_3=$(gnome-terminal -- bash -c "curl -s '$YTD_profile_image' | identify -verbose - > $pwd/$YTD_SAVE/identify-$YouTubeID.txt; exit ; ${SHELL:-bash}")
found=$(notify-send -u normal -t 6200 "Tool : identify (ImageMagick)" "has been scanned" -i $pwd/icon/sc.png)
jsonBefore='{"T4T34M":'$YTD_JSONFORMAT']}}}'
echo "$jsonBefore" > $YTD_SAVE/$YouTubeID.json
found=$(notify-send -u normal -t 7200 "ALL DATA HAS BEEN DOWNLOADED AS JSON" "you will find .json" -i $pwd/icon/js.png)
printf "\n\n\e[38;5;31m\e[1;37m#------[ \e[38;5;120mYour search was successfully done : \e[38;5;120m\e[1;33m$YouTubeID \e[38;5;31m\e[1;37m]------#\e[0m
[ + ] inside path : $pwd/$YTD_SAVE
    *   $YouTubeID.json
    *   exiftool-$YouTubeID.txt
    *   exiv2-$YouTubeID.txt
    *   identify-$YouTubeID.txt
    *   photo_$YouTubeID.jpg

[ + ] video title : \e[37;38;5;119m $YTD_titleName \e[0m 
    *   channel : https://www.youtube.com/channel/\e[37;38;5;119m$YTD_channelLink\e[0m
    *   owner url : \e[37;38;5;120m$YTD_OwnerUrls\e[0m

[ + ] Username : \e[37;38;5;119m $YTD_UserName \e[0m

    *   Views Count : \e[37;38;5;120m$YTD_about_viewCount\e[0m
    *   Description : \e[37;38;5;120m$YTD_Description\e[0m
    *   Photo - image(1): \e[37;38;5;120m$YTD_profile_image\e[0m
    
[ + ] Image metadata library and tools : 
    * exiftool
    * exiv2
    * identify (ImageMagick)

[ + ] INFORMATION :
    *   Ur-api_key : \e[37;38;5;120m$YTD_API_KEY\e[0m
V1.1
" 
