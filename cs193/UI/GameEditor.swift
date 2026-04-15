//
//  GameEditor.swift
//  cs193
//
//  Created by Jagadeesh on 08/04/26.
//

import SwiftUI

struct GameEditor: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var game: CodeBreaker
    
    @State var ShowAlertForInvalidGame:Bool = false
    
    let onChoose:() -> Void
    
    var body: some View {
        
        
        NavigationStack{
            Form{
                Section{
                    TextField("name of game", text: $game.name)
                        .onSubmit {
                            done()
                        }
                }
                Section{
                    PegChoicesChooser(PegChoices: $game.pegColorChoices)
                }
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Done"){
                        done()
                    }
                    .alert("Invalid Game", isPresented: $ShowAlertForInvalidGame){
                        Button("OK"){
                            ShowAlertForInvalidGame = false
                        }
                    } message: {
                        Text("Game must have a name and more than one unique Peg")
                    }
                }
            }
        }
    }
    func done(){
        if game.isValid{
            onChoose()
            dismiss()
            
        }
        else{
            ShowAlertForInvalidGame = true
        }
    }
}


extension CodeBreaker {
    var isValid:Bool{
        return !self.name.isEmpty && Set(self.pegChoices).count >= 2
    }
}


#Preview(traits: .swiftData) {
    let game = CodeBreaker(name: "Unknown", pegChoices: [.orange, .green ])
    GameEditor(game:game){
            print("name change \(game.name)")
            print("peg changed \(game.pegChoices)")
    }
}

