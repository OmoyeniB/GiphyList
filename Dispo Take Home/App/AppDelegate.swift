import UIKit
import SnapKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var standard: AppDelegate? { UIApplication.shared.delegate as? AppDelegate }
    var window: UIWindow?
    var appCoordinator: MainCoordinator?
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      IQKeyboardManager.shared.enable = true
      IQKeyboardManager.shared.keyboardAppearance = .default
      IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}
