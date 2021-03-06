import UIKit

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier,
                                                       for: indexPath) as? MainViewCell
        else { return UITableViewCell() }
        
        if let arrayOfGiphy = gifModel?.data[indexPath.row] {
            cell.setup(with: arrayOfGiphy)
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let id = gifModel?.data[indexPath.row].id  {
            didSelectRow?(id)
        }
    }
}

extension MainViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.replacingOccurrences(of: " ", with: "%20") else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {(_) in
            
            if text.count > 0 {
                MainViewModel.fetchDataForSearchBar(text: text) {
                    result in
                    switch result {
                        case .success(let giphy):
                            DispatchQueue.main.async {
                                self.gifModel = giphy
                                self.tableView.reloadData()
                            }
                            
                        case .failure(_):
                            self.displayError(error: Constants.networkOutOfCoverage)
                    }
                }
            } else {
                self.gifUILoadedFromServer()
            }
        })
    }
}

