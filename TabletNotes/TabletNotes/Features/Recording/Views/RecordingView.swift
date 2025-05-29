import SwiftUI
// SermonRecording, RecordingQuality, RecordingStatus, and AudioRecordingService are defined in Core/Models/Recording and Core/Services/Recording.
// If you see linter errors, ensure all files are in the same target and group in Xcode.
// typealias SermonRecording = TabletNotes.TabletNotes.Core.Models.Recording.SermonRecording
// typealias RecordingQuality = TabletNotes.TabletNotes.Core.Models.Recording.RecordingQuality
// typealias RecordingStatus = TabletNotes.TabletNotes.Core.Models.Recording.RecordingStatus
// typealias AudioRecordingService = TabletNotes.TabletNotes.Core.Services.Recording.AudioRecordingService

struct RecordingView: View {
    var onFinish: ((SermonRecording?) -> Void)? = nil
    @Environment(\.dismiss) private var dismiss
    @StateObject private var audioService = AudioRecordingService.shared
    @State private var permissionGranted = false
    @State private var errorMessage: String? = nil
    @State private var recordingTitle: String = ""
    @State private var isSaving = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Recording")
                .font(.largeTitle)
                .padding()
            if !permissionGranted {
                Text("Microphone permission required.")
                    .foregroundColor(.red)
                Button("Request Permission") {
                    requestPermission()
                }
            } else {
                Text("Elapsed: \(Int(audioService.elapsedTime))s")
                    .font(.title2)
                if audioService.recordingState == .idle || audioService.recordingState == .finished {
                    Button(action: {
                        audioService.startRecording(serviceType: "sermon")
                    }) {
                        Text("Start Recording")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else if audioService.recordingState == .recording {
                    Button(action: {
                        audioService.pauseRecording()
                    }) {
                        Text("Pause")
                            .font(.title2)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        stopAndSave()
                    }) {
                        Text("Stop & Save")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else if audioService.recordingState == .paused {
                    Button(action: {
                        audioService.resumeRecording()
                    }) {
                        Text("Resume")
                            .font(.title2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        stopAndSave()
                    }) {
                        Text("Stop & Save")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            requestPermission()
        }
    }
    
    private func requestPermission() {
        audioService.requestPermissions { granted in
            permissionGranted = granted
            if !granted {
                errorMessage = "Microphone access denied."
            } else {
                errorMessage = nil
            }
        }
    }
    
    private func stopAndSave() {
        audioService.stopRecording()
        // Wait a moment for AVAudioRecorder to finalize file
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            guard let id = audioService.currentRecordingId else {
                errorMessage = "No recording found."
                return
            }
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsDirectory.appendingPathComponent("\(id.uuidString).m4a")
            let duration = audioService.elapsedTime
            let recording = SermonRecording(date: Date(), duration: duration, title: "Recording", fileURL: fileURL.path, quality: RecordingQuality.standard, status: RecordingStatus.completed)
            onFinish?(recording)
            dismiss()
        }
    }
}

#Preview {
    RecordingView()
} 