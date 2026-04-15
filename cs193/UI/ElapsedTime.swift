//
//  ElapsedTime.swift
//  cs193
//
//  Created by Jagadeesh on 06/04/26.
//

import SwiftUI

struct ElapsedTime: View {
    
    var startTime: Date?
    var endTime: Date?
    var elapsedTime: TimeInterval
    
    
    var body: some View {
        if let startTime{
            if let endTime {
                Text(endTime, format: .offset(to: startTime - elapsedTime, allowedFields: [.minute, .second]))
            } else {
                Text(TimeDataSource<Date>.currentDate, format: .offset(to: startTime - elapsedTime, allowedFields: [.minute, .second]))
            }
        }else{
            Image(systemName: "pause")
        }
    }
}
//#Preview {
//    ElapsedTime()
//}
