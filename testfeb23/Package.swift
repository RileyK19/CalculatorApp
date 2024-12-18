////
////  Package.swift
////  testfeb23
////
////  Created by Riley Koo on 3/4/24.
////
//
//
//import PackageDescription
//
//let package = Package(
//    name: "PackageName",
//    platforms: [
//        .macOS(.v11),
//        .iOS(.v14)
//    ],
//    products: [
//        // Products define the executables and libraries a package produces, and make them visible to other packages.
//        .library(
//            name: "PackageName",
//            targets: ["PackageName"])
//    ],
//    dependencies: [
//        // Dependencies declare other packages that this package depends on.
//        .package(url: "https://github.com/aheze/implicit-curves.git", from: "0.8.1"),
//        .package(url: "https://github.com/mattmaddux/FASwiftUI", from: "1.0.4")
//    ],
//    targets: [
//        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
//        // Targets can depend on other targets in this package, and on products in packages this package depends on.
//        .target(
//            name: "PackageName",
//            dependencies: ["FASwiftUI"], // <<<--------- Added this here
//            resources: [
//                .process("Assets")
//            ]
//        ),
//        .testTarget(
//            name: "PackageNameTests",
//            dependencies: ["PackageName", "ViewInspector"])
//    ]
//)
