import UIKit

// MARK: - HomeCoordinatorProtocol
protocol HomeCoordinatorProtocol: Coordinator {
  func redirectToPlaces(places: [PlaceModel])
  func redirectToMap(places: [PlaceModel])
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
  func redirectToPlaces(places: [PlaceModel]) {
    let coordinator = PlacesCoordinator(navigationController: navigationController, places: places)
    coordinator.start()
  }

  func redirectToMap(places: [PlaceModel]) {
    let coordinator = PlacesMapCoordinator(navigationController: navigationController, places: places)
    coordinator.start()
  }
}
