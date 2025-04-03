//
//  ContentView.swift
//  MathTutor
//
//  Created by John Kearon on 4/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var firstNumberEmojis = ""
    @State private var secondNumberEmojis = ""
    
    private let emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    
    var body: some View {
        VStack {
            Spacer()
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
            Group {
                Text("\(firstNumberEmojis)")
                Text("+")
                Text("\(secondNumberEmojis)")
            }
            .font(Font.system(size:80))
            .multilineTextAlignment(.center)
             .minimumScaleFactor(0.5)

            Spacer()
            
            
            Text("\(firstNumber) + \(secondNumber) =")
                .font(.largeTitle)
            
            Spacer()
            
        }
        .padding()
        .onAppear {
            firstNumber = Int.random(in: 1...10)
            secondNumber = Int.random(in: 1...10)
            firstNumberEmojis = String(repeating: emojis.randomElement()!, count: firstNumber)
            secondNumberEmojis = String(repeating: emojis.randomElement()!, count: secondNumber)
//            for _ in 0..<firstNumber {
//                firstNumberEmojis.append(emojis[firstNumber])
//            }
//            for _ in 0..<secondNumber {
//                secondNumberEmojis.append(emojis[secondNumber])
//            }
        }
        
    }
}

#Preview {
    ContentView()
}
