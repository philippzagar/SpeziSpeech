//
//  SpeechTestView.swift
//  TestApp
//
//  Created by Philipp Zagar on 10.11.23.
//

import SwiftUI
import SpeziSpeechRecognizer
import SpeziSpeechSynthesizer


struct SpeechTestView: View {
    @State private var speechRecognizer = SpeechRecognizer()
    @State private var speechSynthesizer = SpeechSynthesizer()
    @State private var message = ""
    
    
    var body: some View {
        VStack {
            ScrollView {
                Text(message)
                    .frame(width: 350, height: 450)
            }
                .frame(width: 350, height: 450)
                .border(.gray)
                .padding()
            
            microphoneButton
                .padding()
        }
    }
    
    private var microphoneButton: some View {
        Button(
            action: {
                microphoneButtonPressed()
            },
            label: {
                Image(systemName: "mic.fill")
                    .accessibilityLabel(Text("Microphone Button"))
                    .font(.largeTitle)
                    .foregroundColor(
                        speechRecognizer.isRecording ? .red : Color(.systemGray2)
                    )
                    .scaleEffect(speechRecognizer.isRecording ? 1.2 : 1.0)
                    .opacity(speechRecognizer.isRecording ? 0.7 : 1.0)
                    .animation(
                        speechRecognizer.isRecording ? .easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default,
                        value: speechRecognizer.isRecording
                    )
            }
        )
    }
    
    
    private func microphoneButtonPressed() {
        if speechRecognizer.isRecording {
            speechRecognizer.stop()
        } else {
            Task {
                do {
                    for try await result in speechRecognizer.start() {
                        message = result.bestTranscription.formattedString
                    }
                }
            }
        }
    }
}

#Preview {
    SpeechTestView()
}
