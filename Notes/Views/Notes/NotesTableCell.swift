import UIKit

final class NotesTableCell: RoundedSwipingTableCell {
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLbl: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "10:34"
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentLbl: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#b2b0b1")
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "10:34"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(titleLbl)
        titleLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -6).isActive = true
        titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        
        addSubview(dateLbl)
        dateLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        dateLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        addSubview(contentLbl)
        contentLbl.leftAnchor.constraint(equalTo: dateLbl.rightAnchor, constant: 6).isActive = true
        contentLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        contentLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -6).isActive = true
        
        addSubview(separatorView)
        separatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        separatorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.25).isActive = true
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
    
    func bindData(_ note: NoteModel) {
        titleLbl.text = note.title
        contentLbl.text = note.body
        dateLbl.text = note.displayDate
    }
}
