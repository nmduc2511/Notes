import UIKit

protocol NewFolderVCDelegate: AnyObject {
    func createFolder(_ folder: FolderModel)
}

final class NewFolderViewController: UIViewController {
    private let mView = NewFolderView()
    weak var delegate: NewFolderVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        mView.addParentView(view)
        setupNaviBar()
    }
    
    private func setupNaviBar() {
        let title = UILabel()
        title.textColor = .white
        title.text = "New Folder"
        title.font = UIFont.boldSystemFont(ofSize: 16)
        navigationItem.titleView = title
        navigationController?.navigationBar.barStyle = .black
        
        let leftBtn = UIButton()
        leftBtn.setTitle("Cancel", for: .normal)
        leftBtn.setTitleColor(.yellowApp, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftBtn.addTarget(self, action: #selector(onTouchCancel), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightBtn = UIButton()
        rightBtn.setTitle("Done", for: .normal)
        rightBtn.setTitleColor(.yellowApp, for: .normal)
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        rightBtn.addTarget(self, action: #selector(onTouchDone), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    @objc private func onTouchCancel() {
        dismiss(animated: true)
    }
    
    @objc private func onTouchDone() {
        if let name = mView.folderName, !name.isEmpty {
            let folder = FolderModel(name: name)
            delegate?.createFolder(folder)
            dismiss(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}
