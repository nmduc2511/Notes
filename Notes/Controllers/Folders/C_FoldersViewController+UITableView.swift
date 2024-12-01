import UIKit

extension C_FoldersViewController: UITableViewDataSource,
                                   UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foldersManagement.totalFolders
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(FoldersTableCell.self)
        let folder = foldersManagement.folder(at: indexPath.row)
        cell.setupView()
        cell.bindingData(folder)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
