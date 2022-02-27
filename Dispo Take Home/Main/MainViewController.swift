import UIKit

class MainViewController: UIViewController {
    var tableView = UITableView()
    var searchController = UISearchController()
    var giphy = [Giphy]()
    let urls =  "https://api.giphy.com/v1/gifs/trending?api_key=lVKYZAM1Ni7MvPA613oBP1qwc7ihzgFU&limit=25&rating=g"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
        configureSerchController()
        
        let dataFetchedFromApi = { (fetchGifData: [Giphy]) in
            self.giphy = fetchGifData
            self.tableView.reloadData()
        }
        GifNetworkCall.shared.fetchGifData(completionHandler: dataFetchedFromApi)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        tableView.frame = view.bounds
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 120
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorColor = .clear
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        navigationItem.searchController = searchController
        setTableViewDelegate()
    }
    
    func setTableViewDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func configureSerchController() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.placeholder = "Type to search ...."
    }
    
}









extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        giphy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier, for: indexPath) as? MainViewCell
        let arrayOfGiphy = giphy[indexPath.row]
            cell?.setup(with: arrayOfGiphy)
        return cell ?? UITableViewCell()
    }
    
    
}

