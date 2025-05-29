// TabletNotes/Features/Recording/Components/RecordingControls.swift

import SwiftUI

struct RecordingControls: View {
    var isRecording: Bool
    var onRecord: () -> Void
    var onPause: () -> Void
    var onStop: () -> Void

    var body: some View {
        HStack(spacing: 24) {
            Button(action: onPause) {
                Image(systemName: isRecording ? "pause.circle.fill" : "play.circle.fill")
                    .font(.largeTitle)
            }
            Button(action: onStop) {
                Image(systemName: "stop.circle.fill")
                    .font(.largeTitle)
            }
            Button(action: onRecord) {
                Image(systemName: "record.circle.fill")
                    .font(.largeTitle)
            }
        }
    }
}