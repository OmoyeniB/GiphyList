import UIKit
import SkeletonView

let vc = DetailViewController()

extension MainViewController {
    
    func gifLoadedOnTheMainThread() {
        let url = URL(string: Constants.getTrendingGifURL)!
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifModel.self) {
            [weak self] result in
            switch result {
                case .success(let giphy):
                    DispatchQueue.main.async {
                        self?.gifItem = giphy
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}


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
