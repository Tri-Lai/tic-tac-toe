//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 19/08/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: GameServices
    @State private var playerName = ""
    @State private var opponentName = ""
    @State private var gameType: GameType = GameType.undefined
    @State private var start = false
    @FocusState private var focus: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 30) {
                    Button {
                        gameType = .bot
                    } label: {
                        VStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 70, maxHeight: 70)
                                .padding(40)
                                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(lineWidth: 3))
                            Text("Single player")
                        }
                    }
                    
                    Button {
                        gameType = .peer
                    } label: {
                        VStack {
                            Image(systemName: "person.2.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 70, maxHeight: 70)
                                .padding(40)
                                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(lineWidth: 3))
                            
                            Text("Two players")
                        }
                    }
                }
                
                Text(gameType.gameTypeDesc)
                    .padding()
                
                VStack {
                    switch gameType {
                    case .bot:
                        VStack {
                            TextField("Your name", text: $playerName)
                        }
                    case .peer:
                        VStack {
                            TextField("First player name", text: $playerName)
                            TextField("Second player name", text: $opponentName)
                        }
                    case .undefined:
                        EmptyView()
                    }
                }
                .padding()
                .textFieldStyle(.roundedBorder)
                .focused($focus)
                .frame(width: 350)
                
                if gameType != .undefined {
                    Button("Start game") {
                        game.setupGame(gameType: gameType, player1Name: playerName, player2Name: opponentName)
                        focus = false
                        start.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(
                        gameType == .undefined ||
                        gameType == .bot && playerName.isEmpty ||
                        gameType == .peer && (playerName.isEmpty || opponentName.isEmpty)
                    )
                }
            }
            .padding()
            .navigationTitle("Tic-tac-toe")
            .fullScreenCover(isPresented: $start, content: {GameView()})
            .onAppear {
                game.resetGame()   // Reset game when new view appear
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: DismissButton())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameServices())
    }
}
