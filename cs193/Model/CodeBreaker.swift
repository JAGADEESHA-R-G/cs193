//
//  CodeBreaker.swift
//  cs193
//
//  Created by Jagadeesh on 31/03/26.
//

import Foundation
import SwiftUI
import SwiftData

typealias peg = String

@Model class CodeBreaker{               // Since this model is a class now it compiles to Identifiable easily
    var name:String
    @Relationship(deleteRule: .cascade) var masterCode: Code = Code(kind: .master(isHidden: true))
    @Relationship(deleteRule: .cascade) var guess: Code = Code(kind: .guess)
    @Relationship(deleteRule: .cascade) var attempts:[Code] = [Code]()
    var pegChoices:[peg]
    @Transient var startTime: Date?
    var endTime: Date?
    var elapsedTime: TimeInterval = 0
        
        
    init(name:String = "codebreaker", pegChoices:[peg]) {
        self.name = name
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    
    var gameOver: Bool {  // returns true when guess matches master else false
        attempts.first?.pegs == masterCode.pegs
    }
    
    func attemptGuess(){
        
        guard !attempts.contains(where: {$0.pegs==guess.pegs}) else {return}
        
//        var attempt = guess
//        attempt.kind = .attempt(guess.match(against: masterCode))
        
        let attempt = Code(kind: .attempt(guess.match(against: masterCode)),        // Added when Code is converted to @Model from struct
                           pegs: guess.pegs)
        
        attempts.insert(attempt, at: 0)
        guess.reset()
        if gameOver{
            masterCode.kind = .master(isHidden: false)
            endTime = .now
            pauseTimer()
        }
    }
    
    func startTimer(){
        if startTime == nil, !gameOver{
            startTime = .now
            elapsedTime += 0.00001
        }
    }
    
    func pauseTimer(){
        if let startTime{
            elapsedTime += Date.now.timeIntervalSince(startTime)
        }
        startTime = nil
    }

    
    func restart(){
        masterCode.kind = .master(isHidden: true)
        masterCode.randomize(from: pegChoices)
        attempts.removeAll()
        guess.reset()
        startTime = .now
        endTime = nil
        elapsedTime = 0
    }
    
    
    func setGuessPeg(_ Peg: peg, at Index: Int) {
        guard guess.pegs.indices.contains(Index) else { return }
        guess.pegs[Index] = Peg
     }
     
    
    func changeGuessPeg(at index: Int){
        
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg){
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices+1)%pegChoices.count]
            guess.pegs[index] = newPeg
        }else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
        
    }
    
}


//
//
//extension CodeBreaker : Identifiable, Hashable, Equatable {
//    
//    static func == (lhs: CodeBreaker, rhs: CodeBreaker) -> Bool {
//        lhs.id == rhs.id                                                // id we get it when we make it identifiable
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//}
//
//
