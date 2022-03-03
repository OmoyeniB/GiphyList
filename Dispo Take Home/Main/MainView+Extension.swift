import UIKit
import SkeletonView
//import Skel

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
    
        func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
           return MainViewCell.identifier
        }
}

//extension MainViewController: UITableViewDelegate {
//
//        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//            tableView.deselectRow(at: indexPath, animated: true)
//    //        let vc = DetailViewController()
//    //        let nav = UINavigationController(rootViewController: vc)
//    //        nav.modalPresentationStyle = .fullScreen
//    //        present(nav, animated: true)
//        }
//}

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



