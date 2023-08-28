//
//  GameView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 20/08/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var game: GameServices
    var body: some View {
        NavigationStack {
            ZStack {
                Image("game-background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy({$0 == false}) {
                        Text("Select a player to start")
                    }
                    HStack {
                        Button(game.player1.name) {
                            game.player1.isCurrent = true
                        }
                        .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                        
                        Button(game.player2.name) {
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
                            Text("Game Over")
                            
                            if game.possibleMoves.isEmpty {
                                Text("No one win")
                            } else {
                                Text("\(game.currentPlayer.name) win!")
                            }
                            
                            Button("New game") {
                                game.resetGame()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .font(.largeTitle)
                    
                    Spacer()
                }
                    .navigationTitle("tic-tac-toe")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Dismiss") {
                                dismiss()
                            }
                            .buttonStyle(.plain)
                        }
                    }
            }
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
