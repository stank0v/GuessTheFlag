//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Hristo Stankov on 20.04.24.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia","France", "Germany", "Ireland","Italy", "Nigeria", "Poland", "Spain","UK","Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameOver = false
    @State private var userScore = 0
    @State private var questionCounter = 1

    
   
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.green.opacity(0.7),.blue.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.title.weight(.heavy))
                    .foregroundStyle(Color.primary)
                Spacer()
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(Color.secondary)
                        .font(.title2.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(Color.primary)
                        .font(.largeTitle.weight(.semibold))
                }.padding(.bottom,30)
                VStack(spacing: 50) {
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 10)
                        }
                        
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Score: \(score)")
                    .padding()
                    .foregroundStyle(.primary)
                    .font(.title.bold())
                Spacer()
               
                Button(action: {
                    score = 0
                }, label: {
                    Text("Restart")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                })

            }
            .padding()
        }
        .alert(scoreTitle,isPresented: $showingScore) {
            if questionCounter != 8 {
                Button("Continue", action:askQuestion)
            } else {
                Button("Restart", action: restartGame)
            }
        } message: {
            if questionCounter != 8 {
                Text("Your score is \(score)")
            } else {
                Text("You ended the game with a score of \(score). Press the restart button to restart the game.")
            }
        }
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
           
           
        } else {
            scoreTitle = "Wroong. That's the flag of \(countries[number])"
            
            
            
        }
        showingScore = true
    }
    func askQuestion() {
       
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
   
    func restartGame() {
          askQuestion()
          questionCounter = 1
          score = 0
      }
}

#Preview {
    ContentView()
}
