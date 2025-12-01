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
  func redirectTo(tour: TourModel) {

  }
}
