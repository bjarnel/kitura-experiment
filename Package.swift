import PackageDescription
 
let package = Package(
    name: "HelloWorld",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 7)
    ]
)

// build project: swift build
// if you changed dependencies: swift package update; swift build
// create/ updated xcode project: swift package generate-xcodeproj