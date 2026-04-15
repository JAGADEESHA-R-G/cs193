//
//  Code.swift
//  cs193
//
//  Created by Jagadeesh on 01/04/26.
//


import Foundation
import SwiftUI
import SwiftData

@Model class Code: Hashable{
//    var id = UUID()       // used in case of making this identifiable
    
    var _kind: String = Kind.unknown.description             // used as proxy for storing in DB
    var pegs: [peg] = Array(repeating: Code.missingPeg, count: 4)
    
    var kind: Kind {
        get{
            return Kind(_kind)          // used for getting _kind variable to actual value
        }
        set{
            _kind = newValue.description        // used for setting the kind variable to _kind string value for storing in DB
        }
    }
    
    init(kind: Kind, pegs: [peg] = Array(repeating: Code.missingPeg, count: 4)) {
        self.kind = kind
        self.pegs = pegs
    }
    
    static let missingPeg: peg = ""
    
//    enum Kind: Hashable, Equatable {
//        case master(isHidden : Bool)
//        case guess
//        case attempt([Match])
//        case unknown
//    }
//    
    
    var isHidden : Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }
    
    
    var matches : [Match] {
        switch kind{
        case .attempt(let matches): return matches
        default: return []
        }
        
    }
    
    
    func reset() {
        self.pegs = Array(repeating: Code.missingPeg, count: 4)
    }
    
    
    
    func randomize(from pegChoices: [peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
        print(pegs)
    }
    
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        
        for index in pegs.indices {
            if results[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        
        return results
    }
    
    
    
    
}


enum Match: String {            // : String gives the rawValue meaing Match.rawValue gives "nomatch" in string format when needed
    case nomatch
    case exact
    case inexact
}
