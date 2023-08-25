//
//  SheetView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 25/08/2023.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var isAnimatingImage = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                    Text("go back")
                        .font(.system(size: 18, weight: .medium))
                    Spacer()
                }
            } // Dimiss button
            .padding(.vertical)
            
            // Image Header
            ImageHeaderView()
                .padding(.horizontal)
            
            // Body
            Form {
                Section {
                    Text("""
                        Tic-tac-toe (Xs or Os, noughts and crosses) is brain boardgame which player has to make three consecutive moves in a row or column before opponent to win the game.
                        """)
                    Text("\"X's and O's, the ultimate battle of free-flow.\"")
                        .italic()
                        .font(.subheadline)
                } header: {
                    Text("Description")
                } footer: {
                    Text("You can rematch many times as you want.")
                }
                
                Section {
                    HStack {
                        Text("App name")
                        Spacer()
                        Text("Epic XO")
                    } // HStack: App name
                    
                    HStack {
                        Text("Course")
                        Spacer()
                        Text("iOS Development")
                    } // HStack: Course
                    
                    HStack {
                        Text("Category")
                        Spacer()
                        Text("Gambling game")
                    } // HStack: Category
                    
                    HStack {
                        Text("Student")
                        Spacer()
                        Text("Tri Lai")
                    } // HStack: Author
                    
                    HStack {
                        Text("ID")
                        Spacer()
                        Text("s3799602")
                    } // HStack: Author ID
                    
                } header: {
                    HStack {
                        Image(systemName: "info.circle.fill")
                        Text("Application Information")
                    }
                }
            }
            
            VStack {
                Text("Copyright © 2023 Epic XO. \nAll rights reserved.")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}

