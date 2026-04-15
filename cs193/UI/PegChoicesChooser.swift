//
//  PegChoicesChooser.swift
//  cs193
//
//  Created by Jagadeesh on 08/04/26.
//

import SwiftUI

struct PegChoicesChooser: View {
    @Binding var PegChoices: [Color]
    var body: some View {
        List{
            ForEach(PegChoices.indices, id:\.self){ index in
                ColorPicker(
                    selection : $PegChoices[index]
                    
                ){
                    button(image: "minus.circle", title: "delete", color:.red){
                        PegChoices.remove(at:index)
                    }
                }
            }
            button(image: "plus.circle", title: "Add Peg", color:.green){
                PegChoices.append(.green)
            }
        }
    }
    
    
    
    func button(
        image: String,
        title: String,
        color:Color,
        action: @escaping () -> Void
    )
    -> some View{
        HStack{
            Button{
                action()
                
            }label:{
                Image(systemName: image).tint(color)
            }
            Text(title)
        }
    }
    
}

#Preview {
    @Previewable @State var PegChoices:[Color] = [Color.green, .red]
    PegChoicesChooser(PegChoices: $PegChoices)
}
