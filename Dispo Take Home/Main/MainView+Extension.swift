import UIKit
import SkeletonView

extension MainViewController {
    
    func gifLoadedOnTheMainThread() {
        
        let dataFetchedFromApi = { (fetchGifData: [Giphy]) in
            DispatchQueue.main.async {
                self.giphy = fetchGifData
                self.tableView.reloadData()
            }
        }
        
        GifNetworkCall.shared.fetchGifData(completionHandler: dataFetchedFromApi)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giphy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier, for: indexPath) as? MainViewCell
        let arrayOfGiphy = giphy[indexPath.row]
        cell?.setup(with: arrayOfGiphy)
        return cell ?? UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = DetailViewController() as DetailViewController
            navigationController?.pushViewController(vc, animated: true)
           
        }
}
