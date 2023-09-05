//
//  tic_tac_toeApp.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 19/08/2023.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct tic_tac_toeApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isDarkMode") private var isDarkMode = false

    
    @StateObject var game = GameServices()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(game)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
