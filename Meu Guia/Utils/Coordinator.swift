import UIKit

// MARK: - Coordinator
protocol Coordinator {

  var navigationController: UINavigationController { get set }

  func start()
}
