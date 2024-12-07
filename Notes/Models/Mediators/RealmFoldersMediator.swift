import Foundation

final class RealmFoldersMediator {
    let folderManager: FoldersManager
    let realmManager: RealmManager
    
    var totalNumberOfFolders: Int {
        return folderManager.folderCount
    }
    
    var defaultFolderId: String {
        return folderManager.defaultFolderId
    }
    
    // MARK: Init
    init(folderManager: FoldersManager,
         realmManager: RealmManager) {
        self.folderManager = folderManager
        self.realmManager = realmManager
    }
    
    func configuration() {
        let rlmFolders = realmManager.objects(RealmFolderModel.self)
        if rlmFolders.isEmpty {
            // create default folder named "Notes"
            let noteFolder = FolderModel(
                name: "Notes",
                type: .general
            )
            
            let rlmFolder = RealmFolderModel(noteFolder)
            realmManager.add(rlmFolder)
            folderManager.setFolders([noteFolder])
        } else {
            // map rlm to useable model
            var folders = [FolderModel]()
            rlmFolders.forEach { realm in
                let folder = FolderModel(realm)
                folders.append(folder)
            }
            
            folders = folders.sorted(
                by: { $0.createdDate.compare($1.createdDate) == .orderedDescending }
            )
            
            folderManager.setFolders(folders)
        }
    }
    
    // MARK: Folder
    func add(_ folder: FolderModel) {
        let rlmFolder = RealmFolderModel(folder)
        realmManager.add(rlmFolder)
        folderManager.add(folder)
    }
    
    // MARK: Note
    func update(_ note: NoteModel) {
        let folder = folderManager.folder(by: note.folderId)
        if !folder.notes
            .contains(where: { $0.id == note.id }) {
            folder.notes.insert(note, at: 0)
        }
        
        let rlmFolder = RealmFolderModel(folder)
        realmManager.update(rlmFolder)
    }
    
    func delete(_ note: NoteModel) {
        folderManager.delete(note)
        let folder = folderManager.folder(by: note.folderId)
        let rlmFolder = RealmFolderModel(folder)
        realmManager.update(rlmFolder)
    }
    
    func deleteAll() {
        realmManager.deleteAll(RealmFolderModel.self)
        folderManager.deleteAll()
    }
}

// MARK: FolderManager
extension RealmFoldersMediator {
    func folder(at index: Int) -> FolderModel {
        return folderManager.folder(at: index)
    }
}
