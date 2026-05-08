import UIKit

// MARK: - PlacesCoordinator
final class ToursCoordinator: Coordinator {
  let homeCoordinator: HomeCoordinatorProtocol
  var navigationController: UINavigationController

  init(homeCoordinator: HomeCoordinatorProtocol, navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.homeCoordinator = homeCoordinator
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
  
  func popToRootViewController() {
    navigationController.popToRootViewController(animated: true)
  }
  
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void) {
    let viewController = CustomFieldCreationViewController()
    viewController.onComplete = completion
    viewController.modalPresentationStyle = .overFullScreen
    navigationController.present(viewController, animated: true)
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
    navigationController.popToRootViewController(animated: true)
    homeCoordinator.redirectToOnlineTours()
  }
  
  func redirectToEditPlace(with place: PlaceModel, of tour: TourModel) {
    let viewModel = PlaceEditViewModel(place: place, tour: tour, coordinator: self)
    let viewController = PlaceEditViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func redirectToSaveLocation() {
    let coordinator = PlaceCreationCoordinator(homeCoordinator: homeCoordinator, navigationController: navigationController)
    coordinator.start()
  }
}
