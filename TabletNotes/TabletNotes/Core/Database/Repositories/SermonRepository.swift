import Foundation

protocol SermonRepositoryProtocol {
    func fetchSermon(by id: String) -> SermonModel?
    func saveSermon(_ sermon: SermonModel)
    func deleteSermon(by id: String)
}

class SermonRepository: SermonRepositoryProtocol {
    func fetchSermon(by id: String) -> SermonModel? {
        // TODO: Implement fetch logic
        return nil
    }
    
    func saveSermon(_ sermon: SermonModel) {
        // TODO: Implement save logic
    }
    
    func deleteSermon(by id: String) {
        // TODO: Implement delete logic
    }
} 