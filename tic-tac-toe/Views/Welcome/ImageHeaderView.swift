//
//  ImageHeaderView.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 25/08/2023.
//

import SwiftUI

struct ImageHeaderView: View {
    @State private var isAnimatingImage: Bool = false
    
    var body: some View {
        ZStack {
            Image("image-header")
                .resizable()
                .scaledToFit()
                .shadow(radius: 8)
                .scaleEffect(isAnimatingImage ? 1.2 : 0.6)
        }
        .frame(width: 300)
        .onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimatingImage = true
            }
        }
    }
}

struct ImageHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageHeaderView()
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
