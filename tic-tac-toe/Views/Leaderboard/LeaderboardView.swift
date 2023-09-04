//
//  LeaderboardView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 03/09/2023.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var leaderboard = LeaderboardModel()
    @Environment(\.colorScheme) var colorScheme

//    @State var playerName = ""
//    @State var winCount = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(colorScheme == .dark ? "blackboard-background" : "whitepaper-background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Top3(top3: [leaderboard.leaderList[0],
                                leaderboard.leaderList[1],
                                leaderboard.leaderList[2]])
                    
                    Divider()
                    
                    if leaderboard.leaderList.count > 3 {
                        OtherRank(leaderboard: leaderboard)
                    }
                    
                }
            }
            .navigationTitle("Leaderboard")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: DismissButton())
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
