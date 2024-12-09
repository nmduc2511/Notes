import UIKit

final class C_FoldersViewController: BaseViewController {
    private var mView = FoldersView()
    private var toolbar = FoldersToolbar()
    var mediator: RealmFoldersMediator!
    var router: FoldersRouter!
    
    // MARK: Life cycle
    override func setupData() {
        mediator.configuration()
    }
    
    // MARK: Setup views
    override func setupView() {
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
    override func setupObservers(
        _ names: [Notification.Name : Selector]) {
        super.setupObservers([
            .noteUpdate: #selector(updateNote),
            .noteDelete: #selector(deleteNote)
        ])
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
