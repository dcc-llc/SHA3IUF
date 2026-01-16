// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SHA3Swift",
	platforms: [
		.iOS(.v13)
	],
	products: [
		.library(name: "SHA3Swift", targets: ["SHA3Swift"]),
		.library(name: "SHA3IUF", targets: ["SHA3IUF"])
	],
	dependencies: [
		.package(
			url: "https://github.com/krzyzanowskim/CryptoSwift.git",
			exact: "1.7.0"
		)
	],
	targets: [
		.target(
			name: "SHA3Swift",
			dependencies: ["SHA3IUF"]),
		.target(
			 name: "SHA3IUF",
			 dependencies: []
		 ),
		.testTarget(
			name: "SHA3SwiftTests",
			dependencies: ["SHA3Swift", "SHA3IUF", "CryptoSwift"]),
	]
)
