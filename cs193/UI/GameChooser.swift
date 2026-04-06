//
//  GameChooser.swift
//  cs193
//
//  Created by Jagadeesh on 06/04/26.
//

import SwiftUI

struct GameChooser: View {
    
    @State private var Games:[CodeBreaker]  = []

    var body: some View {
        NavigationStack{
            List($Games, id: \.pegChoices, editActions: [.delete, .move]){ $game in
                NavigationLink{
                    CodeBreakerView(game:$game)
                }label: {
                    gameSummary(game:game)
                }
            }
            .toolbar{
                EditButton()
            }
        }
        .listStyle(.plain)
        .onAppear{
            Games.append(CodeBreaker(name:"Main", pegChoices: [.red, .green, .orange, .yellow]))
            Games.append(CodeBreaker(name:"second", pegChoices: [.green, .orange, .red, .yellow]))
            Games.append(CodeBreaker(name:"last", pegChoices: [.orange, .green, .orange, ]))
            
        }
            
    }
}

#Preview {
    GameChooser()
}
