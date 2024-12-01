import UIKit

class RoundedTableCell: BaseTableCell {
    private let roundedView = UIView()
    
    override func setupView() {
        setupRoundedView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Reset rounded corners
        roundedView.layer.cornerRadius = 0
        
        // Determine if this is the first or last cell
        if let tableView = superview as? UITableView,
           let indexPath = tableView.indexPath(for: self) {
            if indexPath.row == 0 {
                // First item: Round top-left and top-right corners
                roundedView.layer.cornerRadius = 10
                roundedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // Last item: Round bottom-left and bottom-right corners
                roundedView.layer.cornerRadius = 10
                roundedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        }
        
        // Background color for the rounded corners
        roundedView.backgroundColor = UIColor(hex: "#1C1C1E")
        roundedView.layer.masksToBounds = true
    }
    
    private func setupRoundedView() {
        // Add the roundedView to the contentView
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(roundedView, at: 0)
        
        // Constraints to match the contentView
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
