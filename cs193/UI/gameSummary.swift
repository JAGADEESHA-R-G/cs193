//
//  gameSummary.swift
//  cs193
//
//  Created by Jagadeesh on 06/04/26.
//

import SwiftUI

struct gameSummary: View {
    let game: CodeBreaker
    var body: some View {
        VStack(alignment: .leading){
            Text(game.name)
                .font(.largeTitle)
            pegChooser(choices: game.pegChoices)
                .frame(maxHeight: 50)
            Text("^[\(game.attempts.count) attempt](inflect:true)")
        }
    }
}

#Preview {
    List{
        gameSummary(game:CodeBreaker(name: "check", pegChoices: [.cyan]))
    }
    List {
        gameSummary(game:CodeBreaker(name: "check", pegChoices: [.cyan]))
    }.listStyle(.plain)
}
