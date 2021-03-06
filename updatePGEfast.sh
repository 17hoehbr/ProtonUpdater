#!/usr/bin/env bash
baseuri="https://github.com/Frogging-Family/wine-tkg-git/releases/download"
latesturi="https://api.github.com/repos/Frogging-Family/wine-tkg-git/releases/latest"
dstpath="$HOME/.steam/root/compatibilitytools.d/"

  latestversion="$(curl -s $latesturi | egrep -m1 "tag_name" | cut -d \" -f4)"
  if [[ -d $dstpath/proton_tkg_$latestversion ]]
  then
    echo "Proton $latestversion is the latest version and is already installed."
    echo "Exiting..."
    exit 0
  else
    echo "Proton $latestversion is the latest version and is not installed yet."
    echo "Installing Proton $latestverion"
    url=$(curl -s $latesturi | egrep -m1 "browser_download_url.*proton" | cut -d \" -f4)
  fi

rsp="$(curl -sI "$url" | head -1)"
echo "$rsp" | grep -q 302 || {
  echo "$rsp"
  exit 1
}

[ -d "$dstpath" ] || {
    mkdir "$dstpath"
    echo [Info] Created "$dstpath"
}

curl -sLo "$dstpath/proton_tkg_$latestversion.zip" "$url"
unzip -q "$dstpath/proton_tkg_$latestversion.zip" -d "$dstpath/proton_tkg_$latestversion/"