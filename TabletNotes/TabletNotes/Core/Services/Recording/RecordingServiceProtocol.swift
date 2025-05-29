import Foundation

protocol RecordingServiceProtocol {
    func startRecording()
    func pauseRecording()
    func resumeRecording()
    func stopRecording()
    var isRecording: Bool { get }
    var elapsedTime: TimeInterval { get }
    // TODO: Add delegate or Combine publisher for state updates if needed
}