import UIKit

class NewFolderView: UIView {
    
    lazy var titleTF: UITextField = {
        let tf = UITextField()
        tf.text = "New Folder"
        tf.font = .systemFont(ofSize: 16)
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var containerTF: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#1C1C1E")
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var folderName: String? {
        return titleTF.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        backgroundColor = .black
        
        addSubview(containerTF)
        containerTF.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        containerTF.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        containerTF.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        containerTF.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        containerTF.addSubview(titleTF)
        titleTF.topAnchor.constraint(equalTo: containerTF.topAnchor, constant: 2.5).isActive = true
        titleTF.bottomAnchor.constraint(equalTo: containerTF.bottomAnchor, constant: -2.5).isActive = true
        titleTF.leftAnchor.constraint(equalTo: containerTF.leftAnchor, constant: 12).isActive = true
        titleTF.rightAnchor.constraint(equalTo: containerTF.rightAnchor, constant: -12).isActive = true
    }
    
    func addParentView(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
