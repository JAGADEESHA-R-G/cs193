//
//  SwiftDataPreview.swift
//  cs193
//
//  Created by Jagadeesh on 14/04/26.
//


import SwiftUI
import SwiftData

// 1. The "Factory" that builds the temporary database
struct SwiftDataPreview: PreviewModifier {
    
    // This creates the "Library Building" (Container)
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(
            for: CodeBreaker.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Optional: Add sample data here if you want the preview 
        // to start with games already in the list.
        
        return container
    }
    
    // This wraps your View inside that building so it doesn't crash
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

// 2. The "Shortcut" button for your previews
extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var swiftData: Self = .modifier(SwiftDataPreview())
}
