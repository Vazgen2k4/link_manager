cd ios
rm -rf Podfile.lock Pods
pod repo update
pod install
cd ..
flutter clean
flutter pub get