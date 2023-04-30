#!/bin/bash

NEW_VERSION=$(date '+%y').$(date '+%m').$(date '+%d')
CURRENT_VERSION=$(defaults read $(pwd)/App/iOS/Info CFBundleShortVersionString)

sed -i '' "s/$CURRENT_VERSION/$NEW_VERSION/g" App/iOS/Info.plist
sed -i '' "s/$CURRENT_VERSION/$NEW_VERSION/g" App/WidgetApp/Info.plist