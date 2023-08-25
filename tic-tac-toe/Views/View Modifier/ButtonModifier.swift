//
//  ButtonModifier.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 25/08/2023.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title2, design: .rounded, weight: .bold))
            .frame(width: 200, height: 60)
            .background(
                Capsule()
                    .foregroundColor(.white)
                    .background(
                        ZStack {
                            Color("button-color")
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundColor(.white)
                                .blur(radius: 4)
                                .offset(x: -8, y: -8)
                            
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [Color("button-color"), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .blur(radius: 2)
                                .padding(2)
                        }
                    )
                    .clipShape(Capsule(style: .continuous))
                    .shadow(color: Color("button-color"), radius: 20, x: 10, y:10)
                    .shadow(color: Color.white, radius: 20, x: -10, y: -10)
            )
    }
}
