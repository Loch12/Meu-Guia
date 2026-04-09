import UIKit

// MARK: - PlaceCreationCoordinator
final class PlaceCreationCoordinator: Coordinator {
  let homeCoordinator: HomeCoordinatorProtocol
  var navigationController: UINavigationController
  
  init(homeCoordinator: HomeCoordinatorProtocol, navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.homeCoordinator = homeCoordinator
  }
  
  func start() {
    let viewModel = PlaceCreationViewModel(coordinator: self)
    let viewController = PlaceCreationViewController(viewModel: viewModel)
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
  
  func redirectToToursListing() {
    popToRootViewController()
    homeCoordinator.redirectToSavedTours()
  }
  
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void) {
    let viewController = CustomFieldCreationViewController()
    viewController.onComplete = completion
    viewController.modalPresentationStyle = .overFullScreen
    navigationController.present(viewController, animated: true)
  }
  
  func presentTourCreation(completion: @escaping (TourModel?) -> Void) {
    let viewController = TourCreationViewController()
    viewController.onComplete = completion
    viewController.modalPresentationStyle = .overFullScreen
    navigationController.present(viewController, animated: true)
  }
  
  func redirectToTourSelection(place: PlaceModel) {
    let viewModel = EditingTourViewModel(place: place, coordinator: self)
    let viewController = ToursListingViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: true)
    
  }
}
