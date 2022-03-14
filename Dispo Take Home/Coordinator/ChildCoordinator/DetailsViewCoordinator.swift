import UIKit

final class DetailsViewCoordinator: Coordinator {
    
    private let navigationController: BaseNavigationController

    var rootViewController: UIViewController {
        navigationController
    }

   override init() {
      navigationController = BaseNavigationController()
        super.init()
        navigationController.delegate = self
    }
    override func start() {
        loadDetailsView()
    }
    
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setBackButton()
        
    }
    
    func loadDetailsView() {
        let detailsViewController = DetailViewController()
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
