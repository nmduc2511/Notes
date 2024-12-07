import RealmSwift

final class RealmNoteModel: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var folderId: String
    @Persisted var createdDate: Date
    @Persisted var content: String
    
    convenience init(_ note: NoteModel) {
        self.init()
        id = note.id
        folderId = note.folderId
        createdDate = note.createdDate
        content = note.content
    }
}
