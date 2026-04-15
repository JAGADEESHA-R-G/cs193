//
//  cs193App.swift
//  cs193
//
//  Created by Jagadeesh on 30/03/26.
//
import SwiftUI
import SwiftData

@main
struct cs193App: App {
    var body: some Scene {
        WindowGroup {
//            CodeBreakerView()
            GameChooser()
                .modelContainer(for:CodeBreaker.self)
            
        }
    }
}
