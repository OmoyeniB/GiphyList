import UIKit

final class MainViewCoordinator: Coordinator {
    
   private let navigationController: UINavigationController
   
    var rootViewController: UIViewController {
        navigationController
    }
    
   init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods to be coordinated
    
    override func start() {
        let mainViewController = MainViewController()
        let viewModel = MainViewModel()
        mainViewController.viewModel = viewModel
        mainViewController.didLoadMainView = { [weak self] in self?.finish()
            
        }
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
   
}
