import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var homeCoordinator: HomeCoordinator?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupNavBar()
    setupAudioSession()
    _ = NavigationGuide.shared
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let navVC = UINavigationController()
    self.window?.rootViewController = navVC
    homeCoordinator = HomeCoordinator(navigationController: navVC)
    homeCoordinator?.start()
    LocationService.shared.start()
    self.window?.makeKeyAndVisible()
    return true
  }

  func setupNavBar() {
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.backgroundColor = UIColor.clear
      appearance.backgroundEffect = nil
      appearance.shadowImage = UIImage()
      appearance.shadowColor = .clear
      appearance.backgroundImage = UIImage()
      appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().compactAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
  }
  
  func setupAudioSession() {
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
      try AVAudioSession.sharedInstance().setActive(true)
    } catch {
      print("Erro ao configurar áudio: \(error)")
    }
  }
}
