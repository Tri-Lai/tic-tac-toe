//
//  ViewModifier.swift
//  tic-tac-toe
//
//  Created by Trí Lai on 20/08/2023.
//

import Foundation
import SwiftUI

struct NavStackContainer: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            NavigationStack {
                content
            }
        } else {
                NavigationView {
                    content
                }
                .navigationViewStyle(.stack)
            }
        }
}


extension View {
    public func inNavigationStack() -> some View {
        return self.modifier(NavStackContainer())
    }
}
