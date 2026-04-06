//
//  CodeBreaker.swift
//  cs193
//
//  Created by Jagadeesh on 31/03/26.
//

import Foundation
import SwiftUI

typealias peg = Color

struct CodeBreaker {
    var name:String
    var masterCode: Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind: .guess)
    var attempts:[Code] = [Code]()
    var pegChoices:[peg]
    var startTime: Date = Date.now
    var endTime: Date?
        
    init(name:String = "codebreaker", pegChoices:[peg]) {
        self.name = name
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    
    var gameOver: Bool {  // returns true when guess matches master else false
        attempts.first?.pegs == masterCode.pegs
    }
    
    mutating func attemptGuess(){
        
        guard !attempts.contains(where: {$0.pegs==guess.pegs}) else {return}
        
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.insert(attempt, at: 0)
        guess.reset()
        if gameOver{
            masterCode.kind = .master(isHidden: false)
            endTime = .now
        }
    }
    
    
    mutating func restart(){
        masterCode.kind = .master(isHidden: true)
        masterCode.randomize(from: pegChoices)
        attempts.removeAll()
        guess.reset()
        startTime = .now
        endTime = nil
    }
    
    
    mutating func setGuessPeg(_ Peg: peg, at Index: Int) {
        guard guess.pegs.indices.contains(Index) else { return }
        guess.pegs[Index] = Peg
     }
     
    
    mutating func changeGuessPeg(at index: Int){
        
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg){
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices+1)%pegChoices.count]
            guess.pegs[index] = newPeg
        }else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
        
    }
    
}




