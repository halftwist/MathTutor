//
//  ContentView.swift
//  MathTutor
//
//  Created by John Kearon on 4/3/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var firstNumber = 0
    @State private var secondNumber = 0
//    @State private var CORRECT_ANSWER = 0
    @State private var firstNumberEmojis = ""
    @State private var secondNumberEmojis = ""
    @State private var answer = ""
    @State private var audioPlayer: AVAudioPlayer!  //declares the variable without initializing it
    @State private var textFieldIsDisabled = false
    @State private var buttonIsDisabled = false
    @State private var message = ""
    
//  @FocusState:  Use this property wrapper in conjunction with focused(_:equals:) and focused(_:) to describe views whose appearance and contents relate to the location of focus in the scene.
    @FocusState private var isFocused: Bool
    
    
    private let emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    
    var body: some View {
        VStack {
            Spacer()
            //            Image(systemName: "globe")
            //                .imageScale(.large)
            //                .foregroundStyle(.tint)
            
            //            Group: A type that collects multiple instances of a content type — like views, scenes, or commands — into a single unit.
            Group {
                Text("\(firstNumberEmojis)")
                Text("+")
                Text("\(secondNumberEmojis)")
            }
            .font(Font.system(size:80))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            .animation(.default, value: message)
            
            Spacer()
            
            Text("\(firstNumber) + \(secondNumber) =")
                .font(.largeTitle)
                .animation(.default, value: message)
            
            Spacer()
            
            TextField("", text: $answer)
                .font(.largeTitle)
                .frame(width: 60, alignment:.center)
                .textFieldStyle(.roundedBorder)
            
            //            .overlay: Layers the views that you specify in front of this view.
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                }
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .disabled(textFieldIsDisabled)
            
            Spacer()
            
            Button("Guess") {
//                print("You guessed:\(answer)")
                isFocused = false  // dismisses the Keyboard following press
                
                guard let answerValue = Int(answer) else {
                    print("Please enter a valid number")
                    return
                }
                
                if answerValue == firstNumber + secondNumber {
                    playSound(soundName: "correct")
                    message = "Correct!"
                } else {
                    playSound(soundName: "wrong")
//                    message = "Sorry, the correct answer is \(CORRECT_ANSWER)"
                    message = "Sorry, the correct answer is \(firstNumber + secondNumber)"
                }
                textFieldIsDisabled = true
                buttonIsDisabled = true
              }
            .buttonStyle(.borderedProminent)
            .disabled(answer.isEmpty || buttonIsDisabled)   // A Boolean value that determines whether users can interact with this view.
            
            Spacer()
            
            Text(message)
//                .font(.largeTitle.weight(.black))
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .foregroundStyle(message == "Correct!" ? .green : .red)
                .animation(.default, value: message)
             
            Spacer()
            
            if message != "" {
                Button("Play Again?") {
                    message = ""
                    answer = ""
                     textFieldIsDisabled = false
                    buttonIsDisabled = false
                    generateEquation()
                }
            }
            
              
            Spacer()
            
        }
        .padding()
        .onAppear {
            generateEquation()
            //            for _ in 0..<firstNumber {
            //                firstNumberEmojis.append(emojis[firstNumber])
            //            }
            //            for _ in 0..<secondNumber {
            //                secondNumberEmojis.append(emojis[secondNumber])
            //            }
        }
        
    }
    
    func playSound(soundName: String) {
        
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not find sound file \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer")
        }
        
    }
    
    func generateEquation() {
        firstNumber = Int.random(in: 1...10)
        secondNumber = Int.random(in: 1...10)
        firstNumberEmojis = String(repeating: emojis.randomElement()!, count: firstNumber)
        secondNumberEmojis = String(repeating: emojis.randomElement()!, count: secondNumber)
    }
    
}

#Preview {
    ContentView()
}
