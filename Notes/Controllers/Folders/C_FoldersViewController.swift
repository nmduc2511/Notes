import UIKit

final class C_FoldersViewController: UIViewController {
    private var mView = FoldersView()
    private var toolbar = FoldersToolbar()
    var mediator: RealmFoldersMediator!
    var router: FoldersRouter!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupView()
        setupObserver()
    }
    
    private func setupData() {
        mediator.configuration()
    }
    
    // MARK: Setup views
    private func setupView() {
        mView.addParentView(view)
        mView.add(dataSource: self, delegate: self)
        setupNaviBar()
        setupToolbar()
    }
    
    private func setupNaviBar() {
        let title = UILabel()
        title.textColor = .white
        title.text = "Folders"
        title.font = UIFont.boldSystemFont(ofSize: 16)
        navigationItem.titleView = title
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupToolbar() {
        toolbar.addParentView(view)
        toolbar.othersDelegate = self
    }
    
    // MARK: Setup Observer
    private func setupObserver() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(updateNote),
                name: Notification.Name.noteUpdate,
                object: nil)
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(deleteNote),
                name: Notification.Name.noteDelete,
                object: nil)
    }
    
    @objc func updateNote(_ notification: Notification) {
        guard let note = notification.object as? NoteModel
        else { return }
        
        mediator.update(note)
        mView.reloadFolders()
    }
    
    @objc func deleteNote(_ notification: Notification) {
        guard let note = notification.object as? NoteModel
        else { return }
        
        mediator.delete(note)
        mView.reloadFolders()
    }
}

extension C_FoldersViewController: FoldersToolbarDelegate {
    func onTouchFolder() {
        router.presentNewFolderScreen()
    }
    
    func onTouchNote() {
        let folderId = mediator.defaultFolderId
        let note = NoteModel(folderId: folderId)
        router.pushNoteScreen(note: note)
    }
}

extension C_FoldersViewController: NewFolderVCDelegate {
    func createFolder(_ folder: FolderModel) {
        mediator.add(folder)
        mView.reloadFolders()
    }
}
