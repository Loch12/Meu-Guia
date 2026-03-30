import UIKit

// MARK: - HomeCoordinatorProtocol
protocol HomeCoordinatorProtocol: Coordinator {
  func redirectToOnlineTours()
  func redirectToSavedTours()
  func redirectToSaveLocation()
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
    navigationController.pushViewController(viewController, animated: true)
  }

  func showError(_ error: ErrorResponse) {

  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}

// MARK: - HomeCoordinatorProtocol
extension HomeCoordinator {
  func redirectToOnlineTours() {
    let coordinator = ToursCoordinator(navigationController: navigationController)
    coordinator.start()
  }

  func redirectToSavedTours() {
    let coordinator = ToursCoordinator(navigationController: navigationController)
    coordinator.startOffline()
  }
  
  func redirectToSaveLocation() {
    
  }
}
