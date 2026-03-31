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

  func redirectToPlaceDetail(with place: PlaceModel, of tour: TourModel, isOnline: Bool) {
    let viewModel = PlaceDetailViewModel(place: place, tour: tour, isOnline: isOnline, coordinator: self)
    let viewController = PlaceDetailViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func redirectToOnlineTours() {
    let viewModel = OnlineToursViewModel(coordinator: self)
    let viewController = ToursListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func redirectToNavigation(with place: PlaceModel) {
    let viewModel = PlaceNavigationViewModel(place: place, coordinator: self)
    let viewController = PlaceNavigationViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func redirectToEditPlace(with place: PlaceModel, of tour: TourModel) {
    let viewModel = PlaceEditViewModel(place: place, tour: tour, coordinator: self)
    let viewController = PlaceEditViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
}
