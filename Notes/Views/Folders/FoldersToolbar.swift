import UIKit

protocol FoldersToolbarDelegate: AnyObject {
    func onTouchFolder()
    func onTouchNote()
}

class FoldersToolbar: UIToolbar {
    weak var othersDelegate: FoldersToolbarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        barStyle = .black
        isTranslucent = true // Allow background translucency
        
        // Add toolbar items
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        // Create a UIButton with a resized image
        let addFolderBtn = UIButton(frame: CGRect(x: 5, y: 0, width: 25, height: 40))
        addFolderBtn.addTarget(self, action: #selector(onTouchFolder), for: .touchUpInside)
        let img = UIImageView(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        img.image = UIImage.icAdd.withRenderingMode(.alwaysOriginal)
        addFolderBtn.addSubview(img)
        let leftBarBtn = UIBarButtonItem(customView: addFolderBtn)


        let addNoteBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 40))
        addNoteBtn.addTarget(self, action: #selector(onTouchNote), for: .touchUpInside)
        let img2 = UIImageView(frame: CGRect(x: 5, y: 10, width: 25, height: 25))
        img2.image = UIImage.icEditing.withRenderingMode(.alwaysOriginal)
        addNoteBtn.addSubview(img2)
        let rightBarBtn = UIBarButtonItem(customView: addNoteBtn)
        
        // Add items to the toolbar
        items = [leftBarBtn, flexibleSpace, rightBarBtn]
    }
    
    func addParentView(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        // Position toolbar at the bottom using constraints
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Action for Add button
    @objc func onTouchFolder() {
        othersDelegate?.onTouchFolder()
    }
    
    // Action for Delete button
    @objc func onTouchNote() {
        othersDelegate?.onTouchNote()
    }
}
