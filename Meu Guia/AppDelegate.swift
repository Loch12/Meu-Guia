import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var homeCoordinator: HomeCoordinator?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let navVC = UINavigationController()
    self.window?.rootViewController = navVC
    homeCoordinator = HomeCoordinator(navigationController: navVC)
    homeCoordinator?.start()
    self.window?.makeKeyAndVisible()
    return true
  }
}
