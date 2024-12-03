import RealmSwift

final class FolderRealmModel: Object {
    @Persisted var id: String
    @Persisted var creatingDate: Date
    @Persisted var name: String
    
    convenience init(_ folder: FolderModel) {
        self.init()
        id = folder.id
        creatingDate = folder.creatingDate
        name = folder.name
    }
}
