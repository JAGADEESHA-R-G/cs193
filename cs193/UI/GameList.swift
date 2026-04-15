//
//  GameList.swift
//  cs193
//
//  Created by Jagadeesh on 08/04/26.
//

import SwiftUI

struct GameList: View {
    
    @State private var Games: [CodeBreaker]  = []
    @Binding var Selection: CodeBreaker?
    @State private var showGameEditor: Bool = false
    @State var newGame: CodeBreaker?
    
    var body: some View {
        NavigationStack{
            List(selection : $Selection){       // selection is used as binding to elements in nav links, which we can furthur use to set default etc.
                ForEach(Games){ game in
                    NavigationLink(value: game){
                        gameSummary(game:game)
                    }
                    .contextMenu{
                        Button("Delete", systemImage: "trash", role: .destructive){
                            withAnimation{
                                Games.removeAll(where:{$0 == game})
                            }
                        }
                        editButton(game:game)
                        
                    }
                    .swipeActions(edge: .leading){
                        editButton(game:game).tint(.accentColor)
                    }
                }
                .onDelete{ offsets in
                    Games.remove(atOffsets: offsets )
                }
                .onMove{ offsets, destination in
                    Games.move(fromOffsets: offsets, toOffset: destination)
                }
            }
            .navigationTitle("CodeBreaker")
            .toolbar{
                addGame()
                EditButton()
            }
        }
        .onAppear {
            games()
            }
        }
    
    
    
    func editButton(game:CodeBreaker) -> some View{
        Button("Edit", systemImage: "pencil"){
            newGame = game
        }
    }
    
    
    func addGame() -> some View {
        Button("Add GAme", systemImage: "plus"){
            newGame = CodeBreaker(name: "Unknown", pegChoices: [.orange, .green ])
            showGameEditor = true
        }
        .onChange(of: newGame){
            showGameEditor = newGame != nil
        }
        .sheet(isPresented: $showGameEditor, onDismiss: {
            newGame = nil
        }){
            editGame()
        }
    }
    

    
    @ViewBuilder
    func editGame() -> some View{
        if let newGame {
            let copyOfGameToEdit = CodeBreaker(name: newGame.name, pegChoices: newGame.pegChoices)
            GameEditor(game: copyOfGameToEdit){
                if let index = Games.firstIndex(of: newGame) {
                    Games[index] = copyOfGameToEdit
                } else {
                    Games.insert(newGame, at: 0)
                }
            }
        }
    }
    
    func games(){
        if Games.isEmpty {
            Games.append(CodeBreaker(name:"Main", pegChoices: [.red, .green, .orange, .yellow]))
            Games.append(CodeBreaker(name:"second", pegChoices: [.green, .orange, .red, .yellow]))
            Games.append(CodeBreaker(name:"last", pegChoices: [.orange, .green, .orange, ]))
            Selection = Games.last
        }
    }
}

#Preview(traits: .swiftData)  {
    @Previewable @State  var selection: CodeBreaker? = nil
    NavigationStack{
        GameList(Selection: $selection)
    }
}
