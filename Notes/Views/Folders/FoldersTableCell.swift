import UIKit

class FoldersTableCell: RoundedTableCell {
    lazy var rightImgView: UIImageView = {
        let view = UIImageView(image: .icFolder)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var arrowImgView: UIImageView = {
        let view = UIImageView(image: .icGrayArrow)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLb: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countLb: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#9798a0")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = .clear
        selectionStyle = .none
    
        addSubview(rightImgView)
        rightImgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        rightImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightImgView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        rightImgView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        addSubview(separatorView)
        separatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        separatorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.25).isActive = true
        
        addSubview(titleLb)
        titleLb.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        titleLb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(countLb)
        countLb.rightAnchor.constraint(equalTo: rightAnchor, constant: -32).isActive = true
        countLb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(arrowImgView)
        arrowImgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        arrowImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrowImgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let tableView = superview as? UITableView,
           let indexPath = tableView.indexPath(for: self),
           indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                separatorView.isHidden = true
            } else {
                separatorView.isHidden = false
        }
    }
    
    func bindingData(_ folder: FolderModel) {
        titleLb.text = folder.name
    }
}
