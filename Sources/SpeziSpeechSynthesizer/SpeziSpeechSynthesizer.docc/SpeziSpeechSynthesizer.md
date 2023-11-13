# ``SpeziSpeechSynthesizer``

<!--
                  
This source file is part of the Stanford Spezi open-source project

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

Provides text-to-speech capabilities via Apple's `AVFoundation` framework.

## Overview

The Spezi ``SpeechSynthesizer`` encapsulates the functionality of Apple's `AVFoundation` framework, more specifically the `AVSpeechSynthesizer`.
It provides methods to start and stop voice synthesizing, and publishes the state of the synthesization.

## Setup

### Add Spezi Speech as a Dependency

You need to add the SpeziSpeech Swift package to
[your app in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#) or
[Swift package](https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode#Add-a-dependency-on-another-Swift-package).

## Example

The code example demonstrates the usage of the Spezi ``SpeechSynthesizer`` within a minimal SwiftUI application.

```swift
import SpeziSpeechRecognizer
import SwiftUI


struct SpeechTestView: View {
   /// Instantiate the `SpeechSynthesizer` as a SwiftUI `State` property.
   @State private var speechSynthesizer = SpeechSynthesizer()
   /// A textual message that will be synthesized to natural language speech.
   private let message = "Hello, this is the SpeziSpeech framework!"


   var body: some View {
        /// Button used to start and stop playback of the transcribed message by triggering the `playbackButtonPressed()` function.
        Button("Playback") {
            playbackButtonPressed()
        }
   }

    
   private func playbackButtonPressed() {
      if speechSynthesizer.isSpeaking {
         /// If speech is currently synthezized, pause the playback.
         speechSynthesizer.pause()
      } else {
         /// If synthesizer is idle, start with the text-to-speech functionality.
         speechSynthesizer.speak(message)
      }
   }
}
```

## Topics

- ``SpeechSynthesizer``
