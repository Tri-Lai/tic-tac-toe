//
//  GameServices.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 20/08/2023.
//

import Foundation
import SwiftUI  

@MainActor
class GameServices: ObservableObject {
    @Published var player1 = Player(gamePiece: .x, name: "Player 1");
    @Published var player2 = Player(gamePiece: .o, name: "Player 2");
    @Published var possibleMoves = Move.all
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    @Published var isThinking = false // Device move
    
    @ObservedObject var leaderboard = LeaderboardModel()

    private let agentNames = ["Phoenix", "Sage", "Sova", "Viper", "Cypher", "Reyna", "KillJoy", "Jett", "Raze",
                              "KAY/O", "Chamber", "Neon", "Astra", "Yoru", "Skye"]
    
    // Default game type
    var gameType = GameType.bot
    
    var currentPlayer: Player {
        if player1.isCurrent {
            return player1
        } else {
            return player2
        }
    }
    
    var gameStarted: Bool {
        player1.isCurrent || player2.isCurrent
    }
        
    var boardDisabled: Bool {
        gameOver || !gameStarted || isThinking
    }
    
    func setupGame(gameType: GameType, player1Name: String, player2Name: String) {
        switch gameType {
        case .bot:
            self.gameType = .bot
            player2.name = agentNames.randomElement() ?? "Brimstone"
            
        case .peer:
            self.gameType = .peer
            player2.name = player2Name
            
        case .undefined:
            break
        }
        player1.name = player1Name
    }
    
    func resetGame() {
        player1.isCurrent = false
        player2.isCurrent = false
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Move.all
        gameBoard = GameSquare.reset
    }
    
    func updateMoves(index: Int) {
        if player1.isCurrent {
            player1.moves.append(index + 1) // Add the move of player 1
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index + 1) // Add the move of player 2
            gameBoard[index].player = player2
        }
    }
    
    
    /// Check winning condition on one of two players
    func checkWinning() {
        
        // One player win detected
        if player1.isWinner || player2.isWinner {
            gameOver = true // End the game
            
            // Increase win count of player and add it into Leaderboard
            if player1.isWinner {
                player1.winCount += 1
                updateLeaderBoard(player: player1)
            } else {
                player2.winCount += 1
                updateLeaderBoard(player: player2)
            }
        }
    }
    
    
    func updateLeaderBoard(player: Player) {
        var existedPlayer: Leader?
        
        let isPlayerExist = leaderboard.leaderList.contains(where: { leader in
            if leader.playerName.lowercased() == player.name.lowercased() {
                print("\n\n------\nFOUND!!!")
                existedPlayer = leader
                return true
            } else {
                return false
            }
        })
        
        // Only update winning stat if they already exist in Leaderboard
        if isPlayerExist {
            print("Exist")
            leaderboard.deleteData(leader: existedPlayer!)
            
            leaderboard.writeData(name: player.name, win: player.winCount)
        } else { // Add new player's record
            print("NO Exist")

            leaderboard.writeData(name: player.name, win: player.winCount)
        }
    }
    
    /// Switch play turns
    func toggleCurrent() {
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    
    /// This function allows user to make a move
    /// at a specific location on the game board
    /// - Parameter index: square location
    func makeMove(at index: Int) {
        
        // Player selects a square
        if gameBoard[index].player == nil {
            withAnimation {
                updateMoves(index: index)
            }
            
            checkWinning()
            
            // If game is not over yet then check all the remaining available moves
            if !gameOver {
                if let matchingIndex = possibleMoves.firstIndex(where: {$0 == (index + 1)}) {
                    possibleMoves.remove(at: matchingIndex)
                }
                
                toggleCurrent()
                
                if gameType == .bot && currentPlayer.name == player2.name {
                    Task {
                        await deviceMove()
                    }
                }
            }
            
            // If board are full of moves but no one win
            if possibleMoves.isEmpty {
                gameOver = true
            }
            
        }
    }
    
    func deviceMove() async {
        isThinking.toggle()
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if let move = possibleMoves.randomElement() {
            if let matchingIndex = Move.all.firstIndex(where: {$0 == move}) {
                makeMove(at: matchingIndex)
            }
        }
        
        isThinking.toggle()
    }
    
    /** --- Fire --**/
    
    
}
    
