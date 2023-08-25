//
//  DismissButtonModifier.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 25/08/2023.
//

import SwiftUI

struct DismissButton: View {
    // Binding variable to the parent view
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Current display mode variable (light/ dark)
    @Environment(\.colorScheme) var colorScheme
    
    // Custom back button
    var body : some View {
        // Dimiss the current view (Detailed View) to go back to parent view (List View)
        Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
            HStack {
                Image(systemName: "arrowshape.turn.up.backward.fill")
                Spacer()
                Text("go back")
                    .font(.system(size: 18, weight: .medium))
            }
            // Custom adapt color to light and dark mode
            .foregroundColor(colorScheme == .light ? .black : .purple)
        }
    }
}
