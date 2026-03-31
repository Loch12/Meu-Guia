import UIKit

// MARK: - PlaceCreationCoordinator
final class PlaceCreationCoordinator: Coordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewModel = PlaceCreationViewModel(coordinator: self)
    let viewController = PlaceCreationViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func showError(_ error: ErrorResponse) {

  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}
