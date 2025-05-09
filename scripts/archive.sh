BASE_DIR="build/app/intermediates/merged_native_libs/release/out/lib"
cd "$BASE_DIR"
zip -r ../../../../../../../arch.zip \
    "arm64-v8a" \
    "armeabi-v7a" \
    "x86_64"
cd ../../../../../../../