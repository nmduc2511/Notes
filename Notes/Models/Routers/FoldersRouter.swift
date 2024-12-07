import UIKit

final class FoldersRouter {
    weak var owner: UIViewController!
    
    init(owner: UIViewController) {
        self.owner = owner
    }
    
    func pushNoteScreen(note: NoteModel) {
        let vc = NoteViewController(
            nibName: "NoteViewController",
            bundle: nil)
        vc.note = note
        owner.navigationController?
            .pushViewController(vc, animated: true)
    }
    
    func pushNotesScreen(folder: FolderModel) {
        let vc = NotesViewController(
            nibName: "NotesViewController",
            bundle: nil)
        vc.mediator = NotesMediator(folder: folder)
        vc.router = NotesRouter(owner: vc)
        owner.navigationController?
            .pushViewController(vc, animated: true)
    }
    
    func presentNewFolderScreen() {
        let vc = NewFolderViewController(
            nibName: "NewFolderViewController",
            bundle: nil)
        vc.delegate = owner as? C_FoldersViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        owner.present(nav, animated: true)
    }
}
