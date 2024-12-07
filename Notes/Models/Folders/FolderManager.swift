import Foundation

final class FoldersManager {
    private var folders = [FolderModel]()
    
    var folderCount: Int {
        return folders.count
    }
    
    var defaultFolderId: String {
        return folders
            .filter({
                FolderType(rawValue: $0.type) == .general
            })
            .first?.id ?? ""
    }
    
    func setFolders(_ folders: [FolderModel]) {
        self.folders = folders
    }
        
    func add(_ folder: FolderModel) {
        folders.append(folder)
    }
    
    func add(_ note: NoteModel) {
        if let folder = folders
            .filter({ $0.id == note.folderId }).first,
           folder.notes
            .filter({ $0.id == note.id }).isEmpty {
                folder.notes.insert(note, at: 0)
            }
    }
    
    func delete(_ note: NoteModel) {
        let folder = folder(by: note.folderId)
        if let index = folder.notes
            .firstIndex(where: { $0.id == note.id }) {
            folder.notes.remove(at: index)
        }
    }

    func deleteAll() {
        folders.removeAll()
    }
    
    func folder(at index: Int) -> FolderModel {
        return folders[index]
    }
    
    func folder(by id: String) -> FolderModel {
        return folders.filter({ $0.id == id })[0]
    }
}
