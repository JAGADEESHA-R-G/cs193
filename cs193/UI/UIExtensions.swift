//
//  UIExtensions.swift
//  cs193
//
//  Created by Jagadeesh on 05/04/26.
//

import SwiftUI


// Extending Animation for magic numbers
extension Animation {
    static let CodeBreaker = Animation.easeInOut(duration: 3)
    static let restart = Animation.CodeBreaker
    static let guess = Animation.CodeBreaker
    static let selection = Animation.CodeBreaker
    
    
}

extension AnyTransition {
    static let pegchooser = AnyTransition.offset(x:0, y:200)
    static func attempt(_ gameOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: gameOver ? .opacity : .move(edge: .top),   // move makes it like sliding opacity makes it like one disappearing and appering
            removal: .move(edge: .trailing))
    }
}

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}


