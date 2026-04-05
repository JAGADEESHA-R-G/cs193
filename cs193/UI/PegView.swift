//
//  PegView.swift
//  cs193
//
//  Created by Jagadeesh on 01/04/26.
//

import SwiftUI

struct PegView: View {
    // MARK: DATA IN
    let Peg: peg
    
    // MARK: - Body
    
    let pegShape = Circle()
    var body: some View {
        pegShape
//            .overlay {
//                if Peg == Code.missingPeg {
//                    pegShape
//                         .strokeBorder(Color.gray)
//                 } // white border on top
//            }
            .contentShape(pegShape)
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(Peg)
    }
}

#Preview {
    PegView(Peg:.blue)
        .padding(50)
}
