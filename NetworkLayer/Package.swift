// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Package.swift in NetworkLayer
import PackageDescription

let package = Package(
    name: "NetworkLayer",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "NetworkLayer",
            targets: ["NetworkLayer"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NetworkLayer",
            dependencies: []
        ),
        .testTarget(
            name: "NetworkLayerTests",
            dependencies: ["NetworkLayer"]
        ),
    ]
)
