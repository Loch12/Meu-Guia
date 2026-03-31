import Foundation

// MARK: - PlaceEditViewModelProtocol
protocol PlaceEditViewModelProtocol: AnyObject {}

// MARK: - PlaceEditViewModel
class PlaceEditViewModel: PlaceEditViewModelProtocol {
  // MARK: - Properties
  let coordinator: ToursCoordinator
  let place: PlaceModel
  let tour: TourModel

  init(place: PlaceModel, tour: TourModel, coordinator: ToursCoordinator) {
    self.coordinator = coordinator
    self.place = place
    self.tour = tour
  }
}
