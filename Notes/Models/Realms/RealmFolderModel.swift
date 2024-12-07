import RealmSwift
import Realm

final class RealmFolderModel: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var createdDate: Date
    @Persisted var name: String
    @Persisted var type: Int
    @Persisted var notes: List<RealmNoteModel>
    
    convenience init(_ folder: FolderModel) {
        self.init()
        id = folder.id
        createdDate = folder.createdDate
        name = folder.name
        type = folder.type
        
        let realm = folder.notes.map({ RealmNoteModel($0) })
        let list = List<RealmNoteModel>()
        list.append(objectsIn: realm)
        notes = list
    }
}
