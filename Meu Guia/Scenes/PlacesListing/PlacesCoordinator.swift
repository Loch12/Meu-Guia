import UIKit

// MARK: - PlacesCoordinatorProtocol
protocol PlacesCoordinatorProtocol {
  func redirectTo(place: PlaceModel)
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
    let viewModel = PlacesListingViewModel(coordinator: self, places: places)
    let viewController = PlacesListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func showError(_ error: ErrorResponse) {

  }
}

// MARK: - PlacesCoordinatorProtocol
extension PlacesCoordinator: PlacesCoordinatorProtocol {
  func redirectTo(place: PlaceModel) {
    let viewModel = PlaceDetailViewModel()
    let viewController = PlaceDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
