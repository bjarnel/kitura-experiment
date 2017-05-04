import PackageDescription
 
let package = Package(
    name: "HelloWorld",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2, minor: 1)
    ]
)

// https://libraries.io/swiftpm/github.com%2FPerfectlySoft%2FPerfect-MySQL
// build project: swift build
// if you changed dependencies: swift package update; swift build
// create/ updated xcode project: swift package generate-xcodeproj


// docker:
// http://heidloff.net/article/swift-kitura-docker-bluemix
// port 8080
// need extra ubuntu https://github.com/PerfectlySoft/Perfect-MySQL
// sudo apt-get install libmysqlclient-dev
// docker build -t swift-rest .

// docker run -i -t --entrypoint /bin/bash swift-rest
// exit

// interactive WITH port: docker run -i -p 8080:8080 -t --entrypoint /bin/bash swift-rest

// run:
// docker run -i -p 8080:8080 swift-rest
// mysql port 3306
// --add-host dbhost:10.101.75.11

// docker run --add-host dbhost:10.101.75.11 -p 8080:8080 -it --entrypoint /bin/bash swift-rest
// host pcs own ip is now avaiable inside docker as either IP or dbhost

// .. should use this... https://hub.docker.com/_/mysql/ :-)
