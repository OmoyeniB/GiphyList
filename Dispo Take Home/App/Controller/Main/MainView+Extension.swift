import UIKit
import SkeletonView

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifItem?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier, for: indexPath) as? MainViewCell
        guard let arrayOfGiphy = gifItem?.data[indexPath.row] else { return UITableViewCell() }
        cell?.setup(with: arrayOfGiphy)
        return cell ?? UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.giphID = gifItem?.data[indexPath.row].id ?? "1"
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension MainViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.replacingOccurrences(of: " ", with: "%20") else { return }
      
        let urlString = Constants.getGifSearched(searchText: text)
        let url = URL(string: urlString)
       
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {(_) in
            
            if text.count > 0 {
                
                GifNetworkCall.shared.fetchGifData(url: url, expecting: GifModel.self) { [weak self] result in
                    switch result {
                            
                        case .success(let giphy):
                            print(giphy.data, "This is data")
                            
                            DispatchQueue.main.async {
                                self?.gifItem = giphy
                                self?.tableView.reloadData()
                            }
                            
                        case .failure(let error):
                            self?.ifNetworkIsOutOfCoverageDisplayErrorMessage()
                            print(error.localizedDescription)
                    }
                }
            }
            else {
                
                self.gifUILoadedFromServer()
            }
        })
        
    }
    
}

