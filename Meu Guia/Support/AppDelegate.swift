import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var homeCoordinator: HomeCoordinator?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupNavBar()
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let navVC = UINavigationController()
    self.window?.rootViewController = navVC
    homeCoordinator = HomeCoordinator(navigationController: navVC)
    homeCoordinator?.start()
    self.window?.makeKeyAndVisible()
    return true
  }

  func setupNavBar() {
    if #available(iOS 15, *) {
      let navigationBarAppearance = UINavigationBarAppearance()
      navigationBarAppearance.configureWithOpaqueBackground()
      navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
      navigationBarAppearance.backgroundColor = UIColor.clear
      UINavigationBar.appearance().standardAppearance = navigationBarAppearance
      UINavigationBar.appearance().compactAppearance = navigationBarAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
  }
}
