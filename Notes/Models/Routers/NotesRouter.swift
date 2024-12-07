import UIKit

final class NotesRouter {
    weak var owner: UIViewController!
    
    init(owner: UIViewController) {
        self.owner = owner
    }
    
    func pushNoteScreen(_ note: NoteModel) {
        let vc = NoteViewController(
            nibName: "NoteViewController",
            bundle: nil)
        vc.note = note
        owner.navigationController?
            .pushViewController(vc, animated: true)
    }
}
