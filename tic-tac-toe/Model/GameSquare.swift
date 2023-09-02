//
//  GameSquare.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 21/08/2023.
//

import Foundation
import SwiftUI

struct GameSquare {
    var id: Int             // Presented index from 1-9
    var player: Player?      // Associated player to the square
    
    
    var image: Image {
        if let player = self.player {
            return player.gamePiece.image
        } else {
            return Image("none")
        }
    }
    
    static var reset: [GameSquare] {
        var squares = [GameSquare]()
        
        for index in 1...9 {
            squares.append(GameSquare(id: index))
        }
        
        return squares
    }
}
