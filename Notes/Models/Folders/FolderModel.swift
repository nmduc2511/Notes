import RealmSwift

class FolderModel {
    var id: String
    var createdDate: Date
    var name: String
    var type: Int
    var notes: [NoteModel]
    
    init(name: String, 
         type: FolderType = .other) {
        self.id = UUID().uuidString
        self.createdDate = Date()
        self.name = name
        self.type = type.rawValue
        self.notes = []
    }
    
    init(_ realm: RealmFolderModel) {
        id = realm.id
        createdDate = realm.createdDate
        name = realm.name
        type = realm.type
        notes = realm.notes.map({ NoteModel($0) })
    }
}
