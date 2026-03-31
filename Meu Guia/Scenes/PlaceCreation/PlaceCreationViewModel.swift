import Foundation

// MARK: - PlaceCreationViewModelProtocol
protocol PlaceCreationViewModelProtocol: AnyObject {}

// MARK: - PlaceCreationViewModel
class PlaceCreationViewModel: PlaceCreationViewModelProtocol {
  // MARK: - Properties
  let coordinator: PlaceCreationCoordinator

  init(coordinator: PlaceCreationCoordinator) {
    self.coordinator = coordinator
  }
}
