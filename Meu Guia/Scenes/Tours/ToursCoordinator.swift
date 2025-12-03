import UIKit

// MARK: - PlacesCoordinator
final class ToursCoordinator: Coordinator {
  var navigationController: UINavigationController
  private var tours: [TourModel]

  init(navigationController: UINavigationController, tours: [TourModel]) {
    self.navigationController = navigationController
    self.tours = tours
  }

  func start() {
    let viewModel = OnlineToursViewModel(coordinator: self, tours: tours)
    let viewController = ToursListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func showError(_ error: ErrorResponse) {

  }
}

extension ToursCoordinator {
  func redirectToTour(with id: Int) {
    let viewModel = TourDetailViewModel(id: id, coordinator: self)
    let viewController = TourDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func redirectToPlaceDetail(with id: Int) {
    let viewModel = PlaceDetailViewModel(id: id, coordinator: self)
    let viewController = PlaceDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
