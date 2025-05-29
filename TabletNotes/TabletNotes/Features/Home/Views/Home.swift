import SwiftUI
import SwiftData
// import TabletNotes.Features.Recording.Views // Remove this line, not a real module
// RecordingManager, ServiceType, and RecordingView are defined in local files in the same target.
// If you see linter errors, ensure all files are in the same target and group in Xcode.
// Ensure SermonRecording, RecordingsListView, and RecordingView are in the same target or import their modules if needed

struct Home: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recordings: [SermonRecording]
    @State private var showRecordingView = false

    var body: some View {
        RecordingsListView(recordings: recordings.sorted { $0.date > $1.date }) {
            showRecordingView = true
        }
        .sheet(isPresented: $showRecordingView) {
            RecordingView(
                onFinish: { newRecording in
                    if let rec = newRecording {
                        modelContext.insert(rec)
                    }
                    showRecordingView = false
                }
            )
        }
    }
}

// Duplicate RecordingsListView and dateFormatter removed 