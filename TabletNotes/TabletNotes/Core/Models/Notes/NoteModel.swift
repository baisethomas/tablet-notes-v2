import Foundation
import SwiftData

@Model
public final class SermonNoteModel {
    @Attribute(.unique) public var id: UUID
    public var sermonId: UUID
    public var text: String
    public var createdAt: Date
    public var updatedAt: Date
    
    public init(id: UUID = UUID(), sermonId: UUID, text: String = "", createdAt: Date = .now, updatedAt: Date = .now) {
        self.id = id
        self.sermonId = sermonId
        self.text = text
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

struct NoteModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    // Add more note properties as needed
} 