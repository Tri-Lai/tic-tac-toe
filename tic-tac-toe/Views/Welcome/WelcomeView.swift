//
//  WelcomeView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 25/08/2023.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var game: GameServices
    @State private var animateGradient = false
    @State private var showSheet = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                Image("tic-tac-toe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                Text("Xs or Os")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)

                Spacer()
                
                NavigationLink {
                    ContentView()
                } label: {
                    Text("Play")
                        .modifier(ButtonModifier())
                }
                
                NavigationLink {
                    GameView()
                } label: {
                    Text("How to play")
                        .modifier(ButtonModifier())
                }
                
                NavigationLink {
                    GameView()
                } label: {
                    Text("Leaderboard")
                        .modifier(ButtonModifier())
                }
                
                NavigationLink {
                    GameView()
                } label: {
                    Text("Settings")
                        .modifier(ButtonModifier())
                }
                
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .tint(.white)
                    }
                    .sheet(isPresented: $showSheet) {
                        SheetView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
            .background(
                LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(GameServices())
    }
}
