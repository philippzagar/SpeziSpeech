<!--
                  
This source file is part of the Stanford Spezi open source project

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# SpeziSpeech

[![Build and Test](https://github.com/StanfordSpezi/SpeziSpeech/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/StanfordSpezi/SpeziSpeech/actions/workflows/build-and-test.yml)
[![codecov](https://codecov.io/gh/StanfordSpezi/SpeziSpeech/branch/main/graph/badge.svg?token=X7BQYSUKOH)](https://codecov.io/gh/StanfordSpezi/SpeziSpeech)
[![DOI](https://zenodo.org/badge/573230182.svg)](https://zenodo.org/badge/latestdoi/573230182)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FSpeziSpeech%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/StanfordSpezi/SpeziSpeech)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FSpeziSpeech%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/StanfordSpezi/SpeziSpeech)

Recognize and synthesize natural language speech.

## Overview

The Spezi Speech component provides an easy and convenient way to recognize (speech-to-text) and synthesize (text-to-speech) natural language content, facilitating seamless interaction with an application. It builds on top of Apple's [Speech](https://developer.apple.com/documentation/speech/) and [AVFoundation](https://developer.apple.com/documentation/avfoundation/) frameworks.

## Setup


### 1. Add Spezi Speech as a Dependency

You need to add the Spezi Speech Swift package to
[your app in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#) or
[Swift package](https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode#Add-a-dependency-on-another-Swift-package).

> [!IMPORTANT]  
> If your application is not yet configured to use Spezi, follow the [Spezi setup article](https://swiftpackageindex.com/stanfordspezi/spezi/documentation/spezi/initial-setup) to setup the core Spezi infrastructure.

### 2. Configure target properties

To ensure that your application has the necessary permissions for microphone access and speech recognition, follow the steps below to configure the target properties within your Xcode project:

- Open your project settings in Xcode by selecting *PROJECT_NAME > TARGET_NAME > Info* tab.
- You will need to add two entries to the `Custom iOS Target Properties` (so the `Info.plist` file) to provide descriptions for why your app requires these permissions:
   - Add a key named `Privacy - Microphone Usage Description` and provide a string value that describes why your application needs access to the microphone. This description will be displayed to the user when the app first requests microphone access.
   - Add another key named `Privacy - Speech Recognition Usage Description` with a string value that explains why your app requires the speech recognition capability. This will be presented to the user when the app first attempts to perform speech recognition.

These entries are mandatory for apps that utilize microphone and speech recognition features. Failing to provide them will result in your app being unable to access these features. 

## Example

`SpeechTestView` provides a demonstration of the capabilities of the Spezi Speech module.
It showcases the interaction with the [`SpeechRecognizer`](https://swiftpackageindex.com/stanfordspezi/spezispeech/documentation/spezispeech/speechrecognizer) to provide speech-to-text capabilities and the [`SpeechSynthesizer`](https://swiftpackageindex.com/stanfordspezi/spezispeech/documentation/spezispeech/speechsynthesizer) to generate speech from text.


```swift
struct SpeechTestView: View {
   /// Instantiate the `SpeechRecognizer` and `SpeechSynthesizer` as SwiftUI `State` properties.
   @State private var speechRecognizer = SpeechRecognizer()
   @State private var speechSynthesizer = SpeechSynthesizer()
   /// The transcribed message from the user's voice input.
   @State private var message = ""


   var body: some View {
      VStack {
         /// Button used to start and stop recording by triggering the `microphoneButtonPressed()` function.
         Button("Record") {
            microphoneButtonPressed()
         }
            .padding(.bottom)


         /// Button used to start and stop playback of the transcribed message by triggering the `playbackButtonPressed()` function.
         Button("Playback") {
            playbackButtonPressed()
         }
      }
   }


   private func microphoneButtonPressed() {
      if speechRecognizer.isRecording {
         /// If speech is currently recognized, stop the transcribing.
         speechRecognizer.stop()
      } else {
         /// If the recognizer is idle, start a new recording.
         Task {
            do {
               /// The `speechRecognizer.start()` function returns an `AsyncThrowingStream` that yields the transcribed text.
               for try await result in speechRecognizer.start() {
                  /// Access the string-based result of the transcribed result.
                  message = result.bestTranscription.formattedString
               }
            }
         }
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


## License
This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordSpezi/SpeziSpeech/tree/main/LICENSES) for more information.


## Contributors
This project is developed as part of the Stanford Byers Center for Biodesign at Stanford University.
See [CONTRIBUTORS.md](https://github.com/StanfordSpezi/SpeziSpeech/tree/main/CONTRIBUTORS.md) for a full list of all SpeziSpeech contributors.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
