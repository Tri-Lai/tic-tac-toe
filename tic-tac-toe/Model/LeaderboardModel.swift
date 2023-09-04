//
//  Leaderboard.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 03/09/2023.
//

import Foundation
import Firebase

class LeaderboardModel : ObservableObject {
    @Published var leaderList = [Leader]()
    
    func writeData(name: String, win: Int) {
        // Reference to database
        let db = Firestore.firestore()
        
        db.collection("leaderboards").addDocument(data: ["name": name, "win": win]) { error in
            // No error
            if error == nil {
                self.getData()
            } else {
                //
            }
        }
    }
    
    func updateWinningCountData(leader: Leader) {
        // Reference to database
        let db = Firestore.firestore()
          
        db.collection("leaderboards")
            .document(leader.id)
            .setData(["win": leader.playerWin]) { error in
            
                // No error
                if error == nil {
                    self.getData()
                } else {
                    //
                }
        }
    }
    
    func getData() {
        // Reference to database
        let db = Firestore.firestore()
        
        // Read data at 'leaderboards' path
        db.collection("leaderboards").getDocuments { snapshot, error in
            // No error in fetching
            if error == nil {
                if let snapshot = snapshot { // Unwrap data
                    
                    // Update list of leaders in the leaderboard UI
                    DispatchQueue.main.async {
                        
                        // Add documents in Firebase to array
                        self.leaderList = snapshot.documents.map { document in
                            
                            return Leader(id: document.documentID,
                                          playerName: document["name"] as? String ?? "",
                                          playerWin: document["win"] as? Int ?? 0)
                            
                        }
                    }
                }
            }
        }
    }
    
    func deleteData(leader: Leader) {
        // Reference to database
        let db = Firestore.firestore()
        
        db.collection("leaderboards").document(leader.id).delete {error in
            if error == nil {
                print("Delete \(leader.playerName) success!")
                
                DispatchQueue.main.async {
                    self.leaderList.removeAll { player in
                        return player.id == leader.id
                    }
                }
            }
            
        }
    }
}

