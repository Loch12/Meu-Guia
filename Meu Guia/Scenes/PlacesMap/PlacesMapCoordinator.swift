import UIKit

// MARK: - PlacesMapCoordinatorProtocol
protocol PlacesMapCoordinatorProtocol {
  func redirectTo(place: PlaceModel)
}

// MARK: - PlacesMapCoordinator
final class PlacesMapCoordinator: Coordinator {
  var navigationController: UINavigationController
  let places: [PlaceModel]

  init(navigationController: UINavigationController, places: [PlaceModel]) {
    self.navigationController = navigationController
    self.places = places
  }

  func start() {
    let viewModel = PlacesMapViewModel(coordinator: self, places: places)
    let viewController = PlacesMapViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func showError(_ error: ErrorResponse) {

  }
}

// MARK: - PlacesMapCoordinatorProtocol
extension PlacesMapCoordinator: PlacesMapCoordinatorProtocol {
  func redirectTo(place: PlaceModel) {
    let viewModel = PlaceDetailViewModel(place: place)
    let viewController = PlaceDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
