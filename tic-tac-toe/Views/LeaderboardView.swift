//
//  LeaderboardView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 03/09/2023.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var leaderboard = LeaderboardModel()
    
//    @State var playerName = ""
//    @State var winCount = 0
    
    var body: some View {
        NavigationView {
            VStack {
                List(leaderboard.leaderList) { player in
                    HStack {
                        Text(player.playerName)
                        Spacer()
                        Text("\(player.playerWin)")
                    }
                }
            }
            
            // -- DEBUGGING USAGE--
//            Divider()

//            VStack {
//                TextField("Player name", text: $playerName)
//                    .textFieldStyle(.roundedBorder)
//
//                TextField("Win count", value: $winCount, formatter: NumberFormatter())
//                    .textFieldStyle(.roundedBorder)
//
//
//                Button {
//                    leaderboard.writeData(name: playerName, win: winCount)
//
//                    playerName = ""
//                    winCount = 0
//                } label: {
//                    Text("Add new record")
//                }
//            }
//            .padding()
            
            .navigationTitle("Leaderboard")
        }
    }
    
    // Auto get data whenever this view loads
    init() {
        leaderboard.getData()
    }

}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
