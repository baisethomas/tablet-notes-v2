import Foundation

protocol NoteRepositoryProtocol {
    func fetchNote(by id: String) -> NoteModel?
    func saveNote(_ note: NoteModel)
    func deleteNote(by id: String)
}

class NoteRepository: NoteRepositoryProtocol {
    func fetchNote(by id: String) -> NoteModel? {
        // TODO: Implement fetch logic
        return nil
    }
    
    func saveNote(_ note: NoteModel) {
        // TODO: Implement save logic
    }
    
    func deleteNote(by id: String) {
        // TODO: Implement delete logic
    }
} 