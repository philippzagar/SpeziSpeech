//
// This source file is part of the Stanford Spezi open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import SwiftUI
import SpeziSpeechRecognizer
import SpeziSpeechSynthesizer


@main
struct UITestsApp: App {
    var body: some Scene {
        WindowGroup {
            SpeechTestView()
        }
    }
    
    
    func startRecordingAction() {
        // Insert the start functionality here
        print("Start button tapped")
    }
    
    func stopRecordingAction() {
        // Insert the stop functionality here
        print("Stop button tapped")
    }
}
