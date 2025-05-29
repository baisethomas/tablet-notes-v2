import Foundation
import SwiftData

@Model
public final class SermonRecording: Identifiable {
    @Attribute(.unique) public var id: String
    public var date: Date
    public var duration: TimeInterval
    public var title: String
    public var fileURL: String // Store as String for CoreData compatibility
    public var quality: RecordingQuality
    public var status: RecordingStatus
    
    public init(
        id: String = UUID().uuidString,
        date: Date = .now,
        duration: TimeInterval = 0,
        title: String = "",
        fileURL: String = "",
        quality: RecordingQuality = .standard,
        status: RecordingStatus = .pending
    ) {
        self.id = id
        self.date = date
        self.duration = duration
        self.title = title
        self.fileURL = fileURL
        self.quality = quality
        self.status = status
    }
}

public enum RecordingQuality: String, Codable, CaseIterable {
    case standard
    case high
}

public enum RecordingStatus: String, Codable, CaseIterable {
    case pending
    case completed
    case failed
} 