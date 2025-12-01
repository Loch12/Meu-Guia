import UIKit

// MARK: - HomeCoordinatorProtocol
protocol HomeCoordinatorProtocol: Coordinator {
  func redirectToOnlineTours(tours: [TourModel])
  func redirectToSavedTours(tours: [TourModel])
}

// MARK: - HomeCoordinator
final class HomeCoordinator: HomeCoordinatorProtocol {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewModel = HomeViewModel(coordinator: self)
    let viewController = HomeViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: false)
  }

  func showError(_ error: ErrorResponse) {

  }
}

// MARK: - HomeCoordinatorProtocol
extension HomeCoordinator {
  func redirectToOnlineTours(tours: [TourModel]) {
    let coordinator = ToursCoordinator(navigationController: navigationController, tours: tours)
    coordinator.start()
  }

  func redirectToSavedTours(tours: [TourModel]) {
    let coordinator = ToursCoordinator(navigationController: navigationController, tours: tours)
    coordinator.start()
  }
}
