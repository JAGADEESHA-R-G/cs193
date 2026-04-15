//
//  GameChooser.swift
//  cs193
//
//  Created by Jagadeesh on 06/04/26.
//

import SwiftUI

struct GameChooser: View {
    
    @State private var Selection: CodeBreaker? = nil

    var body: some View {
        NavigationSplitView{
            GameList(Selection: $Selection)
        }
        detail: {
            if let Selection {
                CodeBreakerView(game: Selection)
                    .navigationTitle(Selection.name)
                    .navigationBarTitleDisplayMode(.inline)
            }
            Text("choose a game ")
        }
        
        .listStyle(.plain)

            
    }
}

#Preview(traits: .swiftData)  {
    GameChooser()
}
