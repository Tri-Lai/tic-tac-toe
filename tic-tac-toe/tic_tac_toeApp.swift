//
//  tic_tac_toeApp.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 19/08/2023.
//

import SwiftUI

@main
struct tic_tac_toeApp: App {
    @StateObject var game = GameServices()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
