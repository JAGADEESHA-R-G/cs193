//
//  CodeView.swift
//  cs193
//
//  Created by Jagadeesh on 03/04/26.
//

import SwiftUI

struct CodeView<AncillaryView: View>: View {
    
    // MARK: DATA in
    let code: Code
    
    // MARK: - Data given to me
    @Binding var selection: Int
    
    @ViewBuilder let ancillary : () -> AncillaryView
    
    @Namespace var selection_namespace

    
    init(code: Code,
         selection: Binding<Int> = .constant(-1),
         ancillary: @escaping () -> AncillaryView = {EmptyView()}) {    // escaping is for skipping the func initialization
        self.code = code
        self._selection = selection         // _selection does the actual computation behind it should initialized for binding variables
        self.ancillary = ancillary
    }
    
    // MARK: Data body
    var body: some View {
        
        HStack{
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(Peg: code.pegs[index])
                    .padding(Selection.border)
                    .background{    // overlaying guess pegs
                        Group{
                            if selection==index, code.kind == .guess{
                                Selection.shape
                                    .foregroundStyle(Selection.color)
                                    .matchedGeometryEffect(id: "selectors", in: selection_namespace)
                            }
                        }.animation(Animation.selection, value:selection)
                    }
                    .overlay{   // hiding master block
                        if code.isHidden {
                            Selection.shape
                                .foregroundStyle(Selection.color)
                        }
                        
                    }
                    .transaction{ Transaction in
                        if code.isHidden {  // when user wins animate when restarting no animation fade away master instantly
                            Transaction.animation = nil
                        }
                    }
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay{
                    ancillary()
                }
        }
    }
    
}



fileprivate struct Selection {
    static let cornerRadius : CGFloat = 10
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    static let brightness = 0.7
    static let color:Color = Color.gray(0.8)
    static let border: CGFloat = 10
}



//#Preview {
//    CodeView()
//}



