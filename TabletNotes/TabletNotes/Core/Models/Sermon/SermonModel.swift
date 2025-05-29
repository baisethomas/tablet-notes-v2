import Foundation
import SwiftData

@Model
final class SermonModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var date: Date
    var notes: String
    
    init(id: UUID = UUID(), title: String = "", date: Date = .now, notes: String = "") {
        self.id = id.uuidString
        self.title = title
        self.date = date
        self.notes = notes
    }
} 