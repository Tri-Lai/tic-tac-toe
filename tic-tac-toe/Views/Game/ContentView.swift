//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 19/08/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var game: GameServices
    @State private var playerName = ""
    @State private var opponentName = ""
    @State private var gameType: GameType = GameType.undefined
    @State private var start = false

    @State private var singleModeSelected = false
    @State private var multiplayerModeSelected = false
    
    @State private var singlePlayerTextStyle = false
    @State private var twoPlayerTextStyle = false

    
    @FocusState private var focus: Bool
        
    var body: some View {
        NavigationStack {
            ZStack {
                Image(colorScheme == .dark ? "blackboard-background" : "whitepaper-background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Choose play mode")
                        .font(.largeTitle.weight(.heavy))
                    
                    HStack(spacing: 30) {
                        Button {
                            gameType = .bot
                            multiplayerModeSelected = false
                            singleModeSelected = true
                            
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
                        .buttonStyle(SelectedButtonModifier(isEnabled: singleModeSelected))
                        
                        Button {
                            gameType = .peer
                            multiplayerModeSelected = true
                            singleModeSelected = false
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
                        .buttonStyle(SelectedButtonModifier(isEnabled: multiplayerModeSelected))
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
                        Button {
                            game.setupGame(gameType: gameType, player1Name: playerName, player2Name: opponentName)
                            focus = false
                            start.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "play")
                                Text("Start game")
                            }
                            .padding()
                        }
                        .disabled(
                            gameType == .undefined ||
                            gameType == .bot && playerName.isEmpty ||
                            gameType == .peer && (playerName.isEmpty || opponentName.isEmpty)
                        )
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .shadow(radius: 10)
                    }
                }
                .padding()
                .fullScreenCover(isPresented: $start, content: {GameView()})
                .onAppear {
                    game.resetGame()   // Reset game when new view appear
                }
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

struct SelectedButtonModifier: ButtonStyle {
    var isEnabled: Bool
 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(isEnabled ? Color.blue : Color("button-color")))
            .foregroundColor(.white)
    }
}
