import UIKit

// MARK: - PlacesCoordinatorProtocol
protocol PlacesCoordinatorProtocol {

}

// MARK: - PlacesCoordinator
final class PlacesCoordinator: Coordinator {
  var navigationController: UINavigationController
  let places: [PlaceModel]

  init(navigationController: UINavigationController, places: [PlaceModel]) {
    self.navigationController = navigationController
    self.places = places
  }

  func start() {
    let viewModel = PlacesListingViewModel(places: places)
    let viewController = PlacesListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func showError(_ error: ErrorResponse) {

  }
}

// MARK: - PlacesCoordinatorProtocol
extension PlacesCoordinator: PlacesCoordinatorProtocol {

}
