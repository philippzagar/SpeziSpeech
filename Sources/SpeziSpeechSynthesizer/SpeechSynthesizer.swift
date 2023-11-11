//
// This source file is part of the Stanford Spezi open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import AVFoundation
import Observation


/// The Spezi ``SpeechSynthesizer`` encapsulates the functionality of Apple's `AVFoundation` framework, more specifically the `AVSpeechSynthesizer`.
/// It provides methods to start and stop voice synthesizing, and publishes the state of the synthesization.
///
/// ```swift
/// struct SpeechSynthesizerView: View {
///     @State private var speechRecognizer = SpeechSynthesizer()
///     // A textual message that will be synthesized to natural language speech.
///     private let message = "Hello, this is the SpeziSpeech framework!"
///
///     var body: some View {
///         Button("Playback") {
///             playbackButtonPressed()
///         }
///     }
///
///     private func playbackButtonPressed() {
///         if speechSynthesizer.isSpeaking {
///             speechSynthesizer.pause()
///         } else {
///             speechSynthesizer.speak(message)
///         }
///     }
/// }
/// ```
@Observable
public class SpeechSynthesizer: NSObject, AVSpeechSynthesizerDelegate {
    /// The wrapped  `AVSpeechSynthesizer` instance.
    private let avSpeechSynthesizer = AVSpeechSynthesizer()
    
    
    /// A Boolean value that indicates whether the speech synthesizer is speaking or is in a paused state and has utterances to speak.
    public private(set) var isSpeaking = false
    /// A Boolean value that indicates whether a speech synthesizer is in a paused state.
    public private(set) var isPaused = false
    
    
    override public init() {
        super.init()
        avSpeechSynthesizer.delegate = self
    }
    
    
    /// Adds the text to the speech synthesizer’s queue.
    /// - Parameters:
    ///   - text: A string that contains the text to speak.
    ///   - language: Optional BCP 47 code that identifies the language and locale for a voice.
    public func speak(_ text: String, language: String? = nil) {
        let utterance = AVSpeechUtterance(string: text)
        
        if let language {
            utterance.voice = AVSpeechSynthesisVoice(language: language)
        }
        
        speak(utterance)
    }
    
    /// Adds the utterance to the speech synthesizer’s queue.
    /// - Parameter utterance: An `AVSpeechUtterance` instance that contains text to speak.
    public func speak(_ utterance: AVSpeechUtterance) {
        avSpeechSynthesizer.speak(utterance)
    }
    
    /// Pauses the current output speech from the speech synthesizer.
    /// - Parameters:
    ///   - pauseMethod: Defines when the output should be stopped via the `AVSpeechBoundary`.
    public func pause(at pauseMethod: AVSpeechBoundary = .immediate) {
        if isSpeaking {
            avSpeechSynthesizer.pauseSpeaking(at: pauseMethod)
        }
    }
    
    /// Resumes the output of the speech synthesizer.
    public func continueSpeaking() {
        if isPaused {
            avSpeechSynthesizer.continueSpeaking()
        }
    }
    
    /// Stops the output by the speech synthesizer and cancels all unspoken utterances from the synthesizer’s queue.
    /// It is not possible to resume a stopped utterance.
    /// - Parameters:
    ///   - stopMethod: Defines when the output should be stopped via the `AVSpeechBoundary`.
    public func stop(at stopMethod: AVSpeechBoundary = .immediate) {
        if isSpeaking || isPaused {
            avSpeechSynthesizer.stopSpeaking(at: stopMethod)
        }
    }
    
    
    // MARK: - AVSpeechSynthesizerDelegate
    @_documentation(visibility: internal)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        isSpeaking = true
        isPaused = false
    }
    
    @_documentation(visibility: internal)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        isSpeaking = false
        isPaused = true
    }
    
    @_documentation(visibility: internal)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        isSpeaking = true
        isPaused = false
    }
    
    @_documentation(visibility: internal)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        isPaused = false
    }
    
    @_documentation(visibility: internal)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        isSpeaking = false
        isPaused = false
    }
}
