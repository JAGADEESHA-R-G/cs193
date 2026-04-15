//
//  File.swift
//  cs193
//
//  Created by Jagadeesh on 30/03/26.
//

import SwiftUI


struct MatchMarkers: View {
    
    // MARK: Data IN
    var matches: Array<Match>
    
    // MARK: - Body
    var body: some View {
            HStack{
                VStack{
                    matchMarker(peg: 0)
                    matchMarker(peg: 1)
                }
                VStack{
                    matchMarker(peg: 2)
                    matchMarker(peg: 3)
                }
            }
    }
    
    func matchMarker(peg: Int) -> some View {
        //        let exactCount: Int = matches.count(where: { match in match == .exact })
        //        let foundCount: Int = matches.count(where: { match in match != .nomatch })
        let exactCount = matches.count{ $0 == .exact }
        let foundCount = matches.count{ $0 == .nomatch }

        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
    
}

#Preview {
    MatchMarkers(matches:[.exact, .inexact, .nomatch, .exact])
}
