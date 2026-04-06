//
//  CodeBreakerView.swift
//  cs193
//
//  Created by Jagadeesh on 30/03/26.
//

import SwiftUI
//import SwiftData

struct CodeBreakerView: View {
    
    //MARK: DATA shared with me
    let game: CodeBreaker
    
    // MARK: Data Owned by me
//    @State private var game: CodeBreaker = CodeBreaker(pegChoices: [.gray, .green, .yellow, .red])
    
    @State private var selection = 0
    @State private var restarting: Bool = false
    @State private var hideMostRecentMarkers = true
    
    // MARK: - Body
    var body: some View {
        
        VStack{
//            Button("Restart",systemImage: "arrow.circlepath", action:restart)  // restart button
            CodeView(code :game.masterCode)             // master code
//                    {
//                        ElapsedTime(startTime: game.startTime, endTime: game.endTime)
////                            .flexibleSystemFont()
//                            .monospaced()
//                            .lineLimit(1)
//                    }
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
                    .opacity(restarting && game.gameOver ? 0 : 1 )
                }
                ForEach(game.attempts, id: \.pegs){ attempt in
                    CodeView(code: attempt)
                    {
                        Group {
                            if !hideMostRecentMarkers || attempt.pegs != game.attempts.first?.pegs  {
                                MatchMarkers(matches: attempt.matches)
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
        .toolbar{
            ToolbarItem(placement:.primaryAction){
                Button("Restart",systemImage: "arrow.circlepath", action:restart)  // restart button
            }
            ToolbarItem{
                ElapsedTime(startTime: game.startTime, endTime: game.endTime)
                    .monospaced()
                    .lineLimit(1)
            }
        }
        
    }
    
    func changePegAtSelection(to peg: peg) {
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1)%game.masterCode.pegs.count
    }
    
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
        withAnimation(Animation.restart){
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

#Preview {
    @Previewable @State var game:CodeBreaker = CodeBreaker(name:"Test", pegChoices :[.red, .green, .purple, .orange])
    NavigationStack{
        CodeBreakerView(game:game)
    }
}
