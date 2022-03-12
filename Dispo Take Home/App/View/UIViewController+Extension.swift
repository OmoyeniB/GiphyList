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
    
    public func ifNetworkIsOutOfCoverageDisplayErrorMessage() {
        
        DispatchQueue.main.async {
            self.popUpAlert(title: "Alert",
                            message: "Oops!.. something went wrong. Please check your connection and try again",
                            alertStyle: .alert,
                            actionTitles: ["OK"], actionStyles: [.default], actions: [ { _ in
                print("User out of network coverage")
            }])
        }
    }
    
}
