//
//  OtherRank.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 04/09/2023.
//

import SwiftUI

struct OtherRank: View {
    @ObservedObject var leaderboard: LeaderboardModel
    
    var body: some View {
        ScrollView {
            ForEach(3..<leaderboard.leaderList.count) { idx in
                HStack {
                    Text("\(idx + 1)")
                        .padding(.leading)
                    
                    Image("player1-avatar")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 70)
                        .padding(.trailing, 25)
                        .padding(.leading)
                    
                    Text(leaderboard.leaderList[idx].playerName)
                    
                    Spacer()
                    
                    Text("\(leaderboard.leaderList[idx].playerWin)")
                        .padding()
                }
                .font(.title2)
                .background(Color("light-green"))
                .foregroundColor(.white)
                .padding(.horizontal)
            }
            
            
        }
    }
}


