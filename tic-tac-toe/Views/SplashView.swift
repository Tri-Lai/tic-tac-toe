//
//  SplashView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 24/08/2023.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @StateObject var game = GameServices()

    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(game)
        } else {
            VStack {
                VStack {
                    Image("tic-tac-toe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                    Text("Epic XO")
                        .font(Font.custom("Baskerville-Bold", size: 30))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 2.0,
                    execute: {
                    isActive.toggle()
                })
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
