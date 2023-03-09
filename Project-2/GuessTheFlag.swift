//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dinh Huynh Chanh from 28/02/2023 to 9/3/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var continueGameAlert= false
    // shows whether the user chooses to continue game or not
    @State private var endOfGame = false
    // this will be set to true after 8 games, which is the end of this game
    @State private var scoreTitle = ""
    // checking if the user's choice is "Correct" or "Wrong"
    @State private var scoreCount = 0
    // user's score count
    @State private var gameCount = 0
    // number of games played by the user
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    // shuffled() for shuffling the arr after each preview
    @State private var correctAnswer = Int.random(in: 0...2)
    // the user has to choose the correct one out of the first 3 flags of array
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess The Flag")
                    .font(.largeTitle.bold()) // shorthanded for .largeTitle.weight(.bold)
                    .foregroundColor(.white)
                    .padding(40)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Choose the flag of")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 35, weight: .light))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                        // largeTitle is large size but dependent on the user's
                        // device display,
                        // weight is the "size", like heavy, thin, ultra light and bold
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            continueGameAlert = true
                            
                            if number == correctAnswer {
                                scoreTitle = "Correct! \n You are so good!"
                                scoreCount += 1
                            } else {
                                scoreTitle = "Wrong! \n That's the flag of \(countries[number])."
                            }
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                            // clipShape changes the size of the images
                            // Capsule() makes the edges round
                                .shadow(radius: 8)
                            // makes shadowy background for images
                        }
                    }
                }
                .frame(width: 350, height: 500)
                .padding(.vertical, 35)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Score: \(scoreCount)")
                    .foregroundColor(.white)
                    .font(.system(size: 35))
                    .padding(40)
            }
        }
        // alert at the end of ZStack
        .alert(scoreTitle, isPresented: $continueGameAlert) {
            Button("Continue") {
                continueGame()
                gameCount += 1
                
                if gameCount == 8 {
                    endOfGame = true
                }
            }
        }
        // alert shows whether the user chooses correct answer or not,
        // and continues the game.
        // When the user presses "Continue" button, the game will go on
        
        .alert("Congratulations!", isPresented: $endOfGame) {
            Button("Replay", action: replayGame)
        } message: {
            Text("You've played 8 games. \n Here is your score: \(scoreCount).")
        }
        // alert shows that the user has played 8 games, and displays the total score
    }
    
    func continueGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        // we can change the above values because they are
        // @State properties
    }
    
    func replayGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        gameCount = 0
        scoreCount = 0
        endOfGame = false
    }
    // replayGame() is used to reset the game's properties to default
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}   
