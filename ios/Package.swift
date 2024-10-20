// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "YourApp",
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "10.15.0"))
    ],
    targets: [
        .target(
            name: "YourApp",
            dependencies: [
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
            ]
        )
    ]
)
