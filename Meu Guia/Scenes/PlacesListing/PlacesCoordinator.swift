import UIKit

// MARK: - PlacesCoordinatorProtocol
protocol PlacesCoordinatorProtocol {

}

// MARK: - PlacesCoordinator
final class PlacesCoordinator: Coordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewModel = PlacesListingViewModel()
    let viewController = PlacesListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}

// MARK: - PlacesCoordinatorProtocol
extension PlacesCoordinator: PlacesCoordinatorProtocol {

}
