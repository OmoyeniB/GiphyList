import UIKit
import SnapKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      IQKeyboardManager.shared.enable = true
      IQKeyboardManager.shared.keyboardAppearance = .default
      IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Dismiss"
      IQKeyboardManager.shared.keyboardDistanceFromTextField = 50.0
      IQKeyboardManager.shared.shouldResignOnTouchOutside = true
      IQKeyboardManager.shared.enableAutoToolbar = true
      IQKeyboardManager.shared.shouldPlayInputClicks = false
      
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
}
