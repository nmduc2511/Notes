import UIKit
import SwipeCellKit

final class NotesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let toolbar = FoldersToolbar()
    var mediator: NotesMediator!
    var router: NotesRouter!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
    }
    
    // MARK: - Setup Data
    private func setupData() {
        mediator.configuration()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .black
        setupTableView()
        setupNavi()
        setupToolbar()
        setupObserver()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.registerCellClass(NotesTableCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavi() {
        let title = UILabel()
        title.textColor = .white
        title.text = "Notes"
        title.font = UIFont.boldSystemFont(ofSize: 16)
        navigationItem.titleView = title
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .yellowApp
    }
    
    private func setupToolbar() {
        toolbar.addParentView(view)
        toolbar.othersDelegate = self
        toolbar.hiddenFolderButton = true
    }
    
    // MARK: Setup Observer
    private func setupObserver() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(updateNote),
                name: Notification.Name.noteUpdate,
                object: nil)
    }
    
    @objc func updateNote() {
        mediator.update()
        tableView.reloadData()
    }
}

extension NotesViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(
            style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
                NotificationCenter.default.post(name: .noteDelete, object: self.mediator.note(at: indexPath))
                self.mediator.deleteNote(at: indexPath)
                self.tableView.reloadData()
            }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
}

extension NotesViewController: FoldersToolbarDelegate {
    func onTouchFolder() { }
    
    func onTouchNote() {
        let folderId = mediator.folderId
        let note = NoteModel(folderId: folderId)
        router.pushNoteScreen(note)
    }
}
