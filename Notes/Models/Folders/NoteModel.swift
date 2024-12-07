import Foundation

class NoteModel {
    var id: String
    var folderId: String
    var createdDate: Date
    var content: String
    
    var displayDate: String?
    
    var title: String {
        if let firstNewlineRange = content.range(of: "\n") {
            return String(content[content.startIndex..<firstNewlineRange.lowerBound])
        }
        return content
    }
    
    var body: String {
        if let firstNewlineRange = content.range(of: "\n") {
            return String(content[firstNewlineRange.upperBound..<content.endIndex])
        }
        return "No additional text"
    }
    
    init(id: String = UUID().uuidString,
         folderId: String = "",
         createdDate: Date = Date(),
         content: String = "") {
        self.id = id
        self.folderId = folderId
        self.createdDate = createdDate
        self.content = content
    }
    
    init(_ realm: RealmNoteModel) {
        id = realm.id
        folderId = realm.folderId
        createdDate = realm.createdDate
        content = realm.content
    }
}
