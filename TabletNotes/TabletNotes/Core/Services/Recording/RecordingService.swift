import Foundation
import AVFoundation

class RecordingService: RecordingServiceProtocol {
    private var audioRecorder: AVAudioRecorder?
    private(set) var isRecording: Bool = false
    private(set) var elapsedTime: TimeInterval = 0

    func startRecording() {
        // TODO: Implement AVAudioRecorder setup and start
    }

    func pauseRecording() {
        // TODO: Implement pause logic
    }

    func resumeRecording() {
        // TODO: Implement resume logic
    }

    func stopRecording() {
        // TODO: Implement stop and save logic
    }
}