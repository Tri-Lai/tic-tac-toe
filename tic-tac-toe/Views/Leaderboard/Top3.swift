//
//  Top3.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 04/09/2023.
//

import SwiftUI

struct Top3: View {
    var top3 = [Leader]()
    
    var body: some View {
        
        ZStack {
            HStack {
                VStack(spacing: -10) {
                    Image("player1-avatar")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 5)
                                .fill(.green)
                        }
                    
                    Text(top3[1].playerName)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                    
                    Text("\(top3[1].playerWin)")
                        .foregroundColor(.green)
                        .fontWeight(.heavy)

                }
                .offset(x: 20, y: 35)

                
                VStack(spacing: -10) {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.yellow)
                    
                    Image("player1-avatar")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 5)
                                .fill(.green)
                        }
                    
                    Text(top3[0].playerName)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                    
                    Text("\(top3[0].playerWin)")
                        .foregroundColor(.green)
                        .fontWeight(.heavy)

                }
                .zIndex(1)
                
                VStack(spacing: -10) {
                    Image("player1-avatar")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 5)
                                .fill(.green)
                        }
                    
                    Text(top3[2].playerName)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                    
                    Text("\(top3[2].playerWin)")
                        .foregroundColor(.green)
                        .fontWeight(.heavy)

                }
                .offset(x: -23, y: 48)
            }
        }
        .padding(.bottom, 40)
    }
}

struct Top3_Previews: PreviewProvider {
    static var previews: some View {
        Top3(top3: [Leader(id: "1", playerName: "Iris", playerWin: 10),
                   Leader(id: "2", playerName: "Tommy", playerWin: 9),
                   Leader(id: "3", playerName: "Tim", playerWin: 8)])
    }
}
