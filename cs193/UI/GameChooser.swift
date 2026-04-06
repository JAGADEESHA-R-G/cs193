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
            List{
                ForEach(Games){ game in
                    NavigationLink(value: game){
                        gameSummary(game:game)
                    }
                }
                .onDelete{ offsets in
                    Games.remove(atOffsets: offsets )
                }
                .onMove{ offsets, destination in
                    Games.move(fromOffsets: offsets, toOffset: destination)
                }
            }
            .navigationDestination(for: CodeBreaker.self){game in  // CodeBreaker needs to be hashable here because once we click on navigation link it needs to uniquely identify which one is to to pass to CodeBreakerView
                CodeBreakerView(game: game)
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
