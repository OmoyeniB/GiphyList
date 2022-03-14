import UIKit

extension UIViewController {
    
    public func popUpAlert(title: String, message: String, alertStyle: UIAlertController.Style,
                           actionTitles: [String], actionStyles: [UIAlertAction.Style],
                           actions: [((UIAlertAction) -> Void)]) {
        
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: alertStyle)
        
        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle,
                                       style: actionStyles[index],
                                       handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
    public func displayError(error: String) {
        
        DispatchQueue.main.async {
            self.popUpAlert(title: Constants.popUpTitle,
                            message: error,
                            alertStyle: .alert,
                            actionTitles: [Constants.popUpActionTitles], actionStyles: [.default], actions: [ { _ in
            }])
        }
    }
    
}
