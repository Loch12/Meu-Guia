import Foundation

// MARK: - PlaceDetailViewModelProtocol
protocol PlaceDetailViewModelProtocol: AnyObject {
  func getPlaceInfo() -> PlaceModel
}

// MARK: - PlaceDetailViewModel
class PlaceDetailViewModel: PlaceDetailViewModelProtocol {
  // MARK: - Properties
  let place: PlaceModel
  let coordinator: ToursCoordinator

  init(place: PlaceModel, coordinator: ToursCoordinator) {
    self.place = place
    self.coordinator = coordinator
  }
}

extension PlaceDetailViewModel {
  func getPlaceInfo() -> PlaceModel {
    place
  }
}
