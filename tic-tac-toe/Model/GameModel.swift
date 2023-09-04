//
//  GameModel.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 19/08/2023.
//

import Foundation
import SwiftUI

enum GameType {
    case bot, peer, undefined
    
    var gameTypeDesc: String {
        switch self {
        case .bot:
            return """
            You will play against our intelligent agents. This is a chance to \
            prove who is the King in tic-tac-toe game.
            """
            
        case .peer:
            return "You and your friends will have a deathmatch tic-tac-toe."
            
        default:
            return ""
        }
    }
}

enum GamePiece: String {
    case x, o
    
    var image: Image {
        Image(self.rawValue)
    }
}

struct Player {
    let gamePiece: GamePiece
    var name: String
    var moves: [Int] = []
    var isCurrent = false
    var winCount = 0
    var isWinner: Bool {
        for moves in Move.winingMoves {
            if moves.allSatisfy(self.moves.contains) {
                return true
            }
        }
        return false
    }
}

enum Move {
    static var all = [1,2,3,4,5,6,7,8,9]
    static var winingMoves = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
    ]
}
