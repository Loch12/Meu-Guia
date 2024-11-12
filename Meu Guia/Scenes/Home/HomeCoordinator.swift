import UIKit

// MARK: - HomeCoordinatorProtocol
protocol HomeCoordinatorProtocol {
  func redirectToPlaces()
  func redirectToMap()
}

// MARK: - HomeCoordinator
final class HomeCoordinator: Coordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewModel = HomeViewModel(coordinator: self)
    let viewController = HomeViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: false)
  }
}

// MARK: - HomeCoordinatorProtocol
extension HomeCoordinator: HomeCoordinatorProtocol {
  func redirectToPlaces() {
    let coordinator = PlacesCoordinator(navigationController: navigationController)
    coordinator.start()
  }

  func redirectToMap() {

  }
}
