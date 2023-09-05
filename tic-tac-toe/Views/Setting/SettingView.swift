//
//  SettingView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 05/09/2023.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) var colorScheme

    // Store the current mode theme even the user close app
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("currentLanguage") private var currentLanguage = "United States"

    @State private var defaultDifficulty = "Easy"
    @State private var showEnabled = true
    
    let languages = ["United States", "Vietnamese", "French"]
    let difficultLevel = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(isDarkMode ? "blackboard-background" : "whitepaper-background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
            
                    HStack {
                        Toggle("Music", isOn: $showEnabled)
                    }
                    .padding()
                    .padding(.top)
                    
                    HStack {
                        Toggle("Dark mode", isOn: $isDarkMode)
                    }
                    .padding()
                    
                    HStack {
                        Text("Languages")
                        Spacer()
                        Picker("Languages", selection: $currentLanguage) {
                            ForEach(languages, id: \.self) { lang in
                                HStack {
                                    Image("\(lang)")
                                    Text("  \(lang)")
                                }
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Level")
                        Spacer()
                        Picker("Difficulty", selection: $defaultDifficulty) {
                            ForEach(difficultLevel, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.leading, 50)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    Spacer()
                }
                .font(.title2)
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 4)
                        .fill(Color("light-green"))
                }
                .padding()
            }
            .navigationTitle("Game settings")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: DismissButton())
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color("light-green"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
