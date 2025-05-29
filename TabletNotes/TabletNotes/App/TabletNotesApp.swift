/* TabletNotesApp */

import SwiftUI
import SwiftData

@main
struct TabletNotesApp: App {
    // Configure the model container for SwiftData
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SermonNote.self,
            SermonRecording.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            Home()
                .modelContainer(sharedModelContainer)
        }
    }
}

// Removed duplicate ContentView struct to resolve ambiguity

