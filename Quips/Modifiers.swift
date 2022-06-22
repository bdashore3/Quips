//
//  Modifiers.swift
//  Quips
//
//  Created by Brian Dashore on 6/19/22.
//

import SwiftUI

struct DisabledAppearance: ViewModifier {
    let disabled: Bool

    func body(content: Content) -> some View {
        content
            .disabled(disabled)
            .opacity(disabled ? 0.5 : 1)
    }
}
