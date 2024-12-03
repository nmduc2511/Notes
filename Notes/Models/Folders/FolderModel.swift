import RealmSwift

class FolderModel {
    var id: String
    var creatingDate: Date
    var name: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.creatingDate = Date()
        self.name = name
    }
    
    init(_ realm: FolderRealmModel) {
        id = realm.id
        creatingDate = realm.creatingDate
        name = realm.name
    }
}

protocol FoldersManagementProtocol {
    func add(_ folder: FolderModel)
    func deleteAll()
}

class FoldersManagement: FoldersManagementProtocol {
    private var folders = [FolderModel]()
    
    init() {
        let realm = try! Realm()
        let realmFolders = realm.objects(FolderRealmModel.self)
        realmFolders.forEach { realm in
            let folder = FolderModel(realm)
            folders.append(folder)
        }
        
        folders = folders.sorted(
            by: { $0.creatingDate.compare($1.creatingDate) == .orderedDescending }
        )
    }
    
    var totalFolders: Int {
        return folders.count
    }
    
    func add(_ folder: FolderModel) {
        folders.insert(folder, at: 0)
        let realm = try! Realm()
        try! realm.write {
            realm.add(FolderRealmModel(folder))
        }
    }
    
    func deleteAll() {
        folders.removeAll()
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func folder(at index: Int) -> FolderModel {
        return folders[index]
    }
}
