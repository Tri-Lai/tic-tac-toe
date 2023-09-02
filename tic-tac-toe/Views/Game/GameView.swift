//
//  GameView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 20/08/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var game: GameServices
    
    // Timer
    @State private var gameReset = false
    @State private var timePlayed = 0
    @State private var timeCount = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTickUp = false // Stop the timer working in background proccess
        
    var body: some View {
        NavigationStack {
            ZStack {
                Image(colorScheme == .dark ? "blackboard-background" : "whitepaper-background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        if (!game.gameOver) {
                            Text("Time: \(timePlayed)s")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            Spacer()
                        }
                    }
                    
                    if (game.gameStarted) {
                        HStack {
                            VStack(spacing:-10) {
                                Image("player1-avatar")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 90)
                                
                                Text("\(game.player1.name)")
                                    .foregroundColor((game.player1.isCurrent) ? Color.green : Color.secondary)
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                            
                            VStack(spacing:-10) {
                                Image("player1-avatar")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 90)
                                
                                Text("\(game.player2.name)")
                                    
                                    .foregroundColor((game.player2.isCurrent) ? Color.green : Color.secondary)
                            }
                            .padding(.horizontal)
                            
                        }
                    }
                    
                    Spacer()
                    
                    if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy({$0 == false}) {
                        Text("Start with...")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                    }
                    
                    // Hide player's turn buttons once selected
                    if (!game.gameStarted) {
                        HStack {
                            Button(game.player1.name) {
                                gameReset.toggle()
                                isTickUp.toggle()
                                game.player1.isCurrent = true
                            }
                            .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                            
                            Button(game.player2.name) {
                                gameReset.toggle()
                                isTickUp.toggle()

                                game.player2.isCurrent = true
                                if game.gameType == .bot {
                                    Task {
                                        await game.deviceMove()
                                    }
                                }
                            }
                            .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))

                        }
                        .disabled(game.gameStarted)
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            ForEach(0...2, id:\.self) { index in
                                SquareView(index: index)
                            }
                        }
                        HStack {
                            ForEach(3...5, id:\.self) { index in
                                SquareView(index: index)
                            }
                        }
                        HStack {
                            ForEach(6...8, id:\.self) { index in
                                SquareView(index: index)
                            }
                        }
                    }
                    .overlay {
                        if game.isThinking {
                            VStack {
                                Text("Thinking...")
                                    .foregroundColor(.cyan)
                                    .background(Rectangle().fill(Color.primary))
                                ProgressView()
                            }
                        }
                    }
                    .disabled(game.boardDisabled)
                    
                    // Win/ Lose Message
                    VStack {
                        if game.gameOver {
                            if game.possibleMoves.isEmpty {
                                Text("No one win")
                            } else {
                                Text("\(game.currentPlayer.name) win in \n\(timePlayed) seconds.")
                            }
                            
                            Button("New game") {
                                gameReset.toggle()
                                game.resetGame()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .font(.largeTitle)
                    
                    Spacer()
                }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Dismiss") {
                                dismiss()
                            }
                            .buttonStyle(.plain)
                        }
                    }
            }
            .onReceive(timer, perform: { time in
                guard isTickUp else { return }  // Pause counting time lapse in background.
                if (!game.gameOver) {
                    timePlayed = timeCount
                }
                
                if (gameReset == false) {
                    timeCount = 0
                }
                
                timeCount += 1
            })
            .onChange(of: scenePhase, perform: { newPhase in
                isTickUp = (newPhase == .active) ? true : false
            })
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameServices())
    }
}

// Custom button style for reduce redundancy
struct PlayerButtonStyle: ButtonStyle {
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(isCurrent ? Color.green : Color.gray))
            .foregroundColor(.white)
    }
}
