import UIKit

extension C_FoldersViewController: UITableViewDataSource,
                                   UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediator.totalNumberOfFolders
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(FoldersTableCell.self)
        let folder = mediator.folder(at: indexPath.row)
        cell.setupView()
        cell.bindingData(folder)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folder = mediator.folder(at: indexPath.row)
        router.pushNotesScreen(folder: folder)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
