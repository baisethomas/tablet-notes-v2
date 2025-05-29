import Foundation
import SwiftData

// Basic note entry with timestamp
public struct NoteEntry: Identifiable, Codable {
    public var id = UUID()
    public var timestamp: TimeInterval
    public var text: String
    public var tags: [String]
    public var scripture: String?
    
    public init(timestamp: TimeInterval, text: String, tags: [String] = [], scripture: String? = nil) {
        self.timestamp = timestamp
        self.text = text
        self.tags = tags
        self.scripture = scripture
    }
}

// Main note container model for SwiftData storage
@Model
public class SermonNote {
    public var id: UUID
    public var sermonId: UUID
    public var content: String
    public var entries: [NoteEntry]?
    public var createdAt: Date
    public var updatedAt: Date
    
    public init(sermonId: UUID, content: String = "", entries: [NoteEntry]? = nil) {
        self.id = UUID()
        self.sermonId = sermonId
        self.content = content
        self.entries = entries
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    // Helper to add a timestamped entry
    public func addEntry(text: String, tags: [String] = [], scripture: String? = nil, timestamp: TimeInterval) {
        let entry = NoteEntry(timestamp: timestamp, text: text, tags: tags, scripture: scripture)
        if entries == nil {
            entries = [entry]
        } else {
            entries?.append(entry)
        }
        updatedAt = Date()
    }
} 