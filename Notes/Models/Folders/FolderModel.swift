import Foundation

struct FolderModel {
    var id: String
    var creatingDate: Date
    var name: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.creatingDate = Date()
        self.name = name
    }
    
//    init(id: String, creatingDate: Date, name: String) {
//        self.id = id
//        self.creatingDate = creatingDate
//        self.name = name
//    }
}

protocol FoldersManagementProtocol {
    func add(_ folder: FolderModel)
}

class FoldersManagement: FoldersManagementProtocol {
    private var folders = [FolderModel]()
    
    var totalFolders: Int {
        return folders.count
    }
    
    func add(_ folder: FolderModel) {
        folders.insert(folder, at: 0)
    }
    
    func folder(at index: Int) -> FolderModel {
        return folders[index]
    }
}
