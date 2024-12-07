import UIKit

extension NotesViewController: UITableViewDataSource,
                               UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mediator.numberOfGroups()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediator.numberOfNotes(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(NotesTableCell.self)
        cell.delegate = self
        
        if let note = mediator.note(at: indexPath) {
            cell.bindData(note)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NoteViewController(
            nibName: String(describing: NoteViewController.self),
            bundle: nil)
        vc.note = mediator.note(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = mediator.headerTitle(at: section)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
