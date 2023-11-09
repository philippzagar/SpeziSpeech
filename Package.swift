// swift-tools-version:5.9

//
// This source file is part of the Stanford Spezi open source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "SpeziSpeech",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "SpeziSpeechRecognizer", targets: ["SpeziSpeechRecognizer"]),
        .library(name: "SpeziSpeechSynthesizer", targets: ["SpeziSpeechSynthesizer"])
    ],
    targets: [
        .target(
            name: "SpeziSpeechRecognizer"
        ),
        .target(
            name: "SpeziSpeechSynthesizer"
        ),
        .testTarget(
            name: "SpeziSpeechTests",
            dependencies: [
                .target(name: "SpeziSpeechRecognizer"),
                .target(name: "SpeziSpeechSynthesizer")
            ]
        )
    ]
)
