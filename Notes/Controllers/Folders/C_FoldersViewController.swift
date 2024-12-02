import UIKit

final class C_FoldersViewController: UIViewController {
    let mView = FoldersView()
    let toolbar = FoldersToolbar()
    let foldersManagement = FoldersManagement()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        
        let rightBtn = UIButton()
        rightBtn.setTitle("Reset", for: .normal)
        rightBtn.setTitleColor(.yellowApp, for: .normal)
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        rightBtn.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    // MARK: - Setup Toolbar
    private func setupToolbar() {
        toolbar.addParentView(view)
        toolbar.othersDelegate = self
    }
    
    @objc private func deleteAll() {
        foldersManagement.deleteAll()
        mView.reloadFolders()
    }
}

extension C_FoldersViewController: FoldersToolbarDelegate {
    func onTouchFolder() {
        let vc = NewFolderViewController(
            nibName: String(describing: NewFolderViewController.self),
            bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
        
        vc.creatingNewFolder = { [weak self] folder in
            guard let self = self else { return }
            self.foldersManagement.add(folder)
            self.mView.reloadFolders()
        }
    }
    
    func onTouchNote() {
        
    }
}
