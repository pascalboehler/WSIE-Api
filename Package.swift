// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "WSIE-Api",
    products: [
        .library(name: "WSIE-Api", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        
        // MySQL Driver
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "3.0.0"),
        
        // DotEnv
        .package(url: "https://github.com/SwiftOnTheServer/SwiftDotEnv.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentMySQL", "FluentSQLite", "Vapor", "SwiftDotEnv"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

