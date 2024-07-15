import UIKit

// MARK: - HomeCoordinatorProtocol
protocol HomeCoordinatorProtocol {

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

extension HomeCoordinator: HomeCoordinatorProtocol {

}
