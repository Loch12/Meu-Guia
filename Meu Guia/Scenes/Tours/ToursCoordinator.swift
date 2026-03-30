import UIKit

// MARK: - PlacesCoordinator
final class ToursCoordinator: Coordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewModel = OnlineToursViewModel(coordinator: self)
    let viewController = ToursListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func startOffline() {
    let viewModel = SavedToursViewModel(coordinator: self)
    let viewController = ToursListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func showError(_ error: ErrorResponse) {

  }
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
}

extension ToursCoordinator {
  func redirectToTour(with tour: TourModel, isOnline: Bool) {
    let viewModel = TourDetailViewModel(tour: tour, isOnline: isOnline, coordinator: self)
    let viewController = TourDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }

  func redirectToPlaceDetail(place: PlaceModel, isOnline: Bool) {
    let viewModel = PlaceDetailViewModel(place: place, isOnline: isOnline, coordinator: self)
    let viewController = PlaceDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func redirectToOnlineTours() {
    let viewModel = OnlineToursViewModel(coordinator: self)
    let viewController = ToursListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
