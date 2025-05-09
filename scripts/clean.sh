rm -rf ios/Pods
rm -rf ios/.symlinks
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Generated.xcconfig
rm -rf ~/Library/Developer/Xcode/DerivedData
fvm flutter clean 
fvm flutter pub get


cd ios
pod deintegrate
pod install
cd ..
