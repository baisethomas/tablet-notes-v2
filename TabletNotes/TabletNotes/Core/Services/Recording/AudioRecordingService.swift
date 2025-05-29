import Foundation
import AVFoundation
import Combine
import SwiftUI

// Recording status state
enum RecordingState {
    case idle
    case recording
    case paused
    case processing
    case finished
}

/// Protocol for advanced UI updates from AudioRecordingService
enum RecordingEvent {
    case didStartRecording
    case didPauseRecording
    case didResumeRecording
    case didStopRecording
    case didEnterProcessing
    case didFinishProcessing
    case didEncounterError(Error)
}

protocol AudioRecordingServiceDelegate: AnyObject {
    func audioRecordingService(_ service: AudioRecordingService, didUpdate event: RecordingEvent)
}

// Simple recording manager
class AudioRecordingService: ObservableObject {
    // Shared instance
    static let shared = AudioRecordingService()
    
    // Delegate for advanced UI updates
    weak var delegate: AudioRecordingServiceDelegate?
    
    // Published properties for UI binding
    @Published var recordingState: RecordingState = .idle
    @Published var currentRecordingId: UUID?
    @Published var elapsedTime: TimeInterval = 0
    
    // Audio properties
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    
    // MARK: - Initialization
    /// Initialize manager
    private init() {
        #if os(iOS)
        setupAudioSession()
        #endif
    }
    
    // Setup audio session for recording
    #if os(iOS)
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }
    #endif
    
    /// Request microphone permissions
    /// - Parameter completion: Callback with permission result
    func requestPermissions(completion: @escaping (Bool) -> Void) {
        #if os(iOS)
        AVAudioApplication.requestRecordPermission { granted in
            completion(granted)
        }
        #else
        // For macOS - would need different approach
        completion(false)
        #endif
    }
    
    /// Start recording with a service type and quality settings (auto-selects based on user tier)
    /// - Parameters:
    ///   - serviceType: String describing the recording context
    ///   - quality: Optional quality settings (overrides tiered settings if provided)
    func startRecording(serviceType: String, quality: [String: Any]? = nil) {
        // Create a new recording ID
        let recordingId = UUID()
        self.currentRecordingId = recordingId
        
        // Set up recording file URL in documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentsDirectory.appendingPathComponent("\(recordingId.uuidString).m4a")
        
        // Determine quality settings
        let isPaid = UserAccountManager.shared.isPaidUser()
        let defaultSettings: [String: Any]
        if let quality = quality {
            defaultSettings = quality
        } else if isPaid {
            // Paid user: High quality
            defaultSettings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderBitRateKey: 128000
            ]
        } else {
            // Free user: Standard quality
            defaultSettings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 22050,
                AVNumberOfChannelsKey: 1,
                AVEncoderBitRateKey: 64000
            ]
        }
        
        // Start recording
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: defaultSettings)
            audioRecorder?.record()
            
            // Start timer to track elapsed time
            startTimer()
            
            // Update state
            recordingState = .recording
            delegate?.audioRecordingService(self, didUpdate: .didStartRecording)
        } catch {
            print("Could not start recording: \(error.localizedDescription)")
            delegate?.audioRecordingService(self, didUpdate: .didEncounterError(error))
        }
    }
    
    /// Pause the current recording
    func pauseRecording() {
        audioRecorder?.pause()
        timer?.invalidate()
        recordingState = .paused
        delegate?.audioRecordingService(self, didUpdate: .didPauseRecording)
    }
    
    /// Resume a paused recording
    func resumeRecording() {
        audioRecorder?.record()
        startTimer()
        recordingState = .recording
        delegate?.audioRecordingService(self, didUpdate: .didResumeRecording)
    }
    
    /// Stop the current recording
    func stopRecording() {
        audioRecorder?.stop()
        timer?.invalidate()
        timer = nil
        recordingState = .finished
        delegate?.audioRecordingService(self, didUpdate: .didStopRecording)
    }
    
    /// Enter processing state (e.g., for post-processing audio)
    func enterProcessing() {
        recordingState = .processing
        delegate?.audioRecordingService(self, didUpdate: .didEnterProcessing)
    }
    
    /// Finish processing state
    func finishProcessing() {
        recordingState = .finished
        delegate?.audioRecordingService(self, didUpdate: .didFinishProcessing)
    }
    
    // Start timer for tracking elapsed time
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if let recorder = self.audioRecorder, recorder.isRecording {
                self.elapsedTime = recorder.currentTime
            }
        }
    }
    
    /// Reset for a new recording session
    func reset() {
        stopRecording()
        elapsedTime = 0
        recordingState = .idle
        currentRecordingId = nil
    }
    
    // MARK: - File Management Stubs
    /// Delete a recording file (stub)
    func deleteRecording(withId id: UUID) {
        // TODO: Implement file deletion logic
    }
    
    /// Rename a recording file (stub)
    func renameRecording(withId id: UUID, newName: String) {
        // TODO: Implement file renaming logic
    }
    
    // MARK: - Offline Queueing Stubs
    /// Queue a recording for later processing (stub)
    func queueRecordingForProcessing(withId id: UUID) {
        // TODO: Implement offline queueing logic
    }
    
    deinit {
        audioRecorder?.stop()
        timer?.invalidate()
    }
} 
