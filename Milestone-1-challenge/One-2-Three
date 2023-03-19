//
//  ContentView.swift
//  One 2 Three
//
//  Created by Dinh Huynh Chanh from 12/03/2023 to 13/3/2023.
//
//  Update on 12/3/2023 - I used Int.random for random selection of machineChoice and gameGoal, but it seems like each Int.random works independently from one another, even though I have assigned them to machineChoice and gameGoal variables.
//  It means that the results of these two variable are different after each implementation in the code

//  Update on 13/3/2023 - I have stopped using Int.random and used shuffled() instead. I choose the first element of this shuffled arr for ranndom selection

//  Update on 13/3/2023 (15 minutes later) - The problem is indeed in the Int.random choices and switching to shuffled() is the key. And now, the gameLogic works fine

//  !!!: change the UI of this app please! It looks not that ugly but not beautiful enough to be published
//

import SwiftUI

// Custom view for non-title text
struct NormalText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(Font.custom("Sono", size: 35))
    }
}

// Custom view for title text
struct TitleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(Font.custom("OpenSans", size: 45))
            .foregroundColor(.white)
    }
}

// Custom view for images, which are rock, paper, and scissor
struct GameImage: View {
    var text: String
    
    var body: some View {
        Image(text)
            .resizable()
            .frame(width: 110, height: 110)
    }
}

// Custom modifier for the background of the game layout
struct mainBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 360, height: 500)
            .padding(.vertical, 35)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func makeBackground() -> some View {
        modifier(mainBackground())
    }
}

struct ContentView: View {
    // Array of game choices: rock, paper, scissor
    @State private var gameChoicesForPlayer = ["rock", "paper", "scissor"]
    
    // Array of the same game choices but shuffled for random selecion
    // I create 2 seperate arrs since the above is a fixed selection of game choices for later use in Image, and the below is for random selection
    @State private var gameChoicesForMachine = ["rock", "paper", "scissor"].shuffled()
    
    // Array of the game goals: (to) win, lose, or draw
    // shuffled() for random selection as well
    @State private var gameGoals = ["WIN", "LOSE", "DRAW"].shuffled()
    
    // Computed properties for the selection of the first element of shuffled gameGoals
    // This is my attempt to have random element without the use of Int.random
    var gameGoal: String {
        return gameGoals[0]
    }
    var machineChoice: String {
        return gameChoicesForMachine[0]
    }
    
    // This is alerting the users for continuing the game or not
    @State private var continueGameAlert = false
    
    // This is alerting the end of the game (after 10 turns)
    @State private var endGameAlert = false
    
    // This counts the game turns up until 10
    @State private var gameCount = 0
    
    // This counts the user's scores
    @State private var scoreCount = 0
    
    // This shows the user's choice if it is "Correct" or "Wrong"
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .mint], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                // use the custom TitleText above
                TitleText(text: "One 2 Three")
                
                VStack(spacing: 30) {
                    VStack {
                        // use the custom NormalText above
                        NormalText(text: "Machine")
                        
                        Spacer()
                        
                        Image(machineChoice)
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                        Spacer()
                        
                        NormalText(text: "Try to \(gameGoal)")
                        
                        Spacer()
                        
                        HStack {
                            // Create 3 buttons in a HStack
                            ForEach(0..<3) { number in
                                Button {
                                    // Upon pressed will show continueGame alert
                                    continueGameAlert = true
                                    
                                    // The gameLogic() func is explained below
                                    gameLogic(for: gameChoicesForPlayer[number])
                                } label: {
                                    GameImage(text: gameChoicesForPlayer[number])
                                }
                            }
                        }
                        
                        Spacer()
                        
                        NormalText(text: "You")
                    }
                }
                // use the custom modifier above
                .makeBackground()
                
                TitleText(text: "Score: \(scoreCount)")
            }
        }
        // Alert shows the user has to continue the game and increments the game count after being pressed
        .alert(scoreTitle, isPresented: $continueGameAlert) {
            Button("Continue") {
                continueGame()
                
                gameCount += 1
                
                if gameCount == 10 {
                    endGameAlert = true
                }
            }
        }
        
        // Alert shows  the user has completed 10 turns ans asks to replay the game
        .alert("Congratulations!", isPresented: $endGameAlert) {
            Button("Replay", action: replayGame)
        } message: {
            NormalText(text: "You've played 10 games. \n Here is your score: \(scoreCount)/10.")
        }
    }
    
    // This re-shuffles the game's arrays for another random selection
    func continueGame() {
        gameChoicesForMachine.shuffle()
        gameGoals.shuffle()
    }
    
    // This replays the game by setting the below variables back to 0
    func replayGame() {
        gameCount = 0
        scoreCount = 0
        endGameAlert = false
    }
    
    // This is the game logic
    func gameLogic(for choice: String) {
        switch gameGoal {
            // if the gameGoal is "WIN", then the game will work in the below logic
            // Here you can see that I use the easiest way possible, which is simply compare the machineChoice to the choice of the user
            // if it is rock then it has to be paper to WIN
            case "WIN":
                if machineChoice == "rock" && choice == "paper" {
                    // if the user choose "paper" then they get 1 point and get congratulated by the scoreTitle
                    scoreCount += 1
                    scoreTitle = "Correct! You are sharp!"
                } else if machineChoice == "paper" && choice == "scissor" {
                    scoreCount += 1
                    scoreTitle = "Correct! You are sharp!"
                } else if machineChoice == "scissor" && choice == "rock" {
                    scoreCount += 1
                    scoreTitle = "Correct! You are sharp!"
                } else {
                    scoreTitle = "Wrong! But, you get this!"
                }
            case "DRAW":
                // the case "DRAW" is the simplest of the three cases
                if choice == machineChoice {
                    scoreCount += 1
                    scoreTitle = "Correct! You are sharp!"
                } else {
                    scoreTitle = "Wrong! But, you get this!"
                }
            case "LOSE":
                if machineChoice == "rock" && choice == "scissor" {
                    scoreCount += 1
                    scoreTitle = "Correct! You are sharp!"
                } else if machineChoice == "paper" && choice == "rock" {
                    scoreCount += 1
                    scoreTitle = "Correct! You are sharp!"
                } else if machineChoice == "scissor" && choice == "paper" {
                    scoreCount += 1
                    scoreTitle = "Correct! You are sharp!"
                } else {
                    scoreTitle = "Wrong! But, you get this!"
                }
            // I need to have a default case so that switch can be exhaustive
            default:
                print("") // simply a nonsensical line of code
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
