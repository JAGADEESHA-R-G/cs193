//
//  CodeBreakerView.swift
//  cs193
//
//  Created by Jagadeesh on 30/03/26.
//

import SwiftUI
//import SwiftData

struct CodeBreakerView: View {
    
    // MARK: Data Owned by me
    @State private var game: CodeBreaker = CodeBreaker(pegChoices: [.gray, .green, .yellow, .red])
    
    @State private var selection = 0
    @State private var restarting: Bool = false
    @State private var hideMostRecentMarkers = true
    
    // MARK: - Body
    var body: some View {
        
        VStack{
            
            Button("Restart", action:restart)  // restart button
            CodeView(code :game.masterCode)             // master code
                    {
                        Text("0:03").font(.title)
                    }
            ScrollView{
                if !game.gameOver || restarting {                      // scroll view for guess and attempts
                    CodeView(code :game.guess,
                             selection:$selection)
                    {
                        Button("guess", action:guess)
                        .font(.system(size: guessButtonmagic.maximumfontSize))
                        .minimumScaleFactor(guessButtonmagic.scaleFactor)
                    }
                    .animation(nil, value: game.attempts.count)    // makes the sliding from guess to attempts doesnt leave any after images.
                    .opacity(restarting ? 0 : 1 )
                }
                ForEach(game.attempts.indices.reversed(), id: \.self){ index in
                    CodeView(code: game.attempts[index])
                    {
                        Group {
                            if !hideMostRecentMarkers || index != game.attempts.count - 1 {
                                MatchMarkers(matches: game.attempts[index].matches)
                            }else{
                                EmptyView()
                            }
                        }
                    }
                }
                .transition(.attempt(game.gameOver))
            }
            if !game.gameOver{
                pegChooser(choices:game.pegChoices, onChoose: { peg in   // peg chooser
                    changePegAtSelection(to: peg)
                }).transition(AnyTransition.pegchooser)
            }
        }
    }
    
    func changePegAtSelection(to peg: peg) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1)%game.masterCode.pegs.count
    }
    
//    
//    var guessButton: some View {
//        Button("guess", action:guess)
//        .font(.system(size: guessButtonmagic.maximumfontSize))
//        .minimumScaleFactor(guessButtonmagic.scaleFactor)
//    }
    
    
    
    func guess() {
        withAnimation{
            game.attemptGuess()
            selection = 0
            hideMostRecentMarkers = true
        }
        completion: {
            withAnimation(Animation.guess){
                hideMostRecentMarkers = false
            }
        }
    }
    
    
    func restart(){
        withAnimation{
            restarting = true
        }
        completion: {
            withAnimation(Animation.restart){
                game.restart()
                selection = 0
                restarting = false
            }
        }
    }
    
    
    
    
    
    struct guessButtonmagic{
        static let minimumfontSize: CGFloat = 8
        static let maximumfontSize: CGFloat = 80
        static let scaleFactor = minimumfontSize / maximumfontSize
    }
    
}

// Extending Animation for magic numbers
extension Animation {
    static let CodeBreaker = Animation.easeInOut(duration: 3)
    static let restart = Animation.CodeBreaker
    static let guess = Animation.CodeBreaker
    
}

extension AnyTransition {
    static let pegchooser = AnyTransition.offset(x:0, y:200)
    static func attempt(_ gameOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: gameOver ? .opacity : .move(edge: .top),   // move makes it like sliding opacity makes it like one disappearing and appering
            removal: .move(edge: .trailing))
    }
}


extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}


#Preview {
    CodeBreakerView()
}
