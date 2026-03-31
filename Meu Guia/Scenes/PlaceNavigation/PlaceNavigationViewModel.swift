import Foundation

// MARK: - PlaceNavigationViewModelProtocol
protocol PlaceNavigationViewModelProtocol: AnyObject {}

// MARK: - PlaceNavigationViewModel
class PlaceNavigationViewModel: PlaceNavigationViewModelProtocol {
  // MARK: - Properties
  let place: PlaceModel
  let coordinator: ToursCoordinator

  init(place: PlaceModel, coordinator: ToursCoordinator) {
    self.place = place
    self.coordinator = coordinator
  }
}
