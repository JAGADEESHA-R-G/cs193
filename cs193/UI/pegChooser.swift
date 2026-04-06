//
//  pegChooser.swift
//  cs193
//
//  Created by Jagadeesh on 03/04/26.
//

import SwiftUI

struct pegChooser: View {
    
    let choices: [peg]
    var onChoose: ((peg) -> Void)?
    
    
//    @Binding var game:CodeBreaker
//    @Binding var selection:Int
    
    var body: some View {
        HStack{
            ForEach(choices, id: \.self) { peg in
                Button(action: {
                        onChoose?(peg)
                }) {
                    PegView(Peg: peg)
                }
            }
        }
    }
}

//#Preview {
//    pegChooser()
//}


//var body: some View {
//
//}
//
//
//HStack{
//    ForEach(game.pegChoices, id: \.self) { peg in
//        Button(action: {
//            game.setGuessPeg(peg, at: selection)
//            selection = (selection + 1)%game.masterCode.pegs.count
//        }) {
//            PegView(Peg: peg)
//        }
//    }
//}
