import SwiftUI
import AVFoundation
// If you see linter errors, ensure this file is in the same target as SermonRecording, or add the correct import if needed.

class AudioPlayerService: NSObject, ObservableObject, AVAudioPlayerDelegate {
    static let shared = AudioPlayerService()
    @Published var currentlyPlayingId: String? = nil
    private var player: AVAudioPlayer?

    func play(recording: SermonRecording) {
        let url = URL(fileURLWithPath: recording.fileURL)
        print("Trying to play file at:", url.path)
        print("File exists:", FileManager.default.fileExists(atPath: url.path))
        do {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try? AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
            currentlyPlayingId = recording.id
        } catch {
            print("Playback failed: \(error)")
        }
    }

    func stop() {
        player?.stop()
        currentlyPlayingId = nil
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentlyPlayingId = nil
    }
}

struct RecordingsListView: View {
    let recordings: [SermonRecording]
    let onNewRecording: () -> Void
    @StateObject private var playerService = AudioPlayerService.shared

    var body: some View {
        NavigationView {
            List(recordings) { rec in
                VStack(alignment: .leading) {
                    HStack {
                        Text(rec.title.isEmpty ? "Untitled Recording" : rec.title)
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            if playerService.currentlyPlayingId == rec.id {
                                playerService.stop()
                            } else {
                                playerService.play(recording: rec)
                            }
                        }) {
                            Image(systemName: playerService.currentlyPlayingId == rec.id ? "stop.circle.fill" : "play.circle.fill")
                                .font(.title2)
                        }
                    }
                    Text("Date: \(rec.date.formatted(date: .abbreviated, time: .shortened))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Duration: \(Int(rec.duration))s")
                        .font(.caption)
                    Text("Quality: \(rec.quality.rawValue.capitalized)")
                        .font(.caption)
                    Text("Status: \(rec.status.rawValue.capitalized)")
                        .font(.caption)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Recordings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: onNewRecording) {
                        Label("New Recording", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    RecordingsListView(recordings: [
        SermonRecording(
            id: UUID().uuidString,
            date: Date(),
            duration: 60,
            title: "Test Recording",
            fileURL: "",
            quality: .standard,
            status: .completed
        )
    ], onNewRecording: {})
}
#endif 