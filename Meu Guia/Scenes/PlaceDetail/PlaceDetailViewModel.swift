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
  let isOnline: Bool

  init(place: PlaceModel, isOnline: Bool, coordinator: ToursCoordinator) {
    self.place = place
    self.coordinator = coordinator
    self.isOnline = isOnline
  }
}

extension PlaceDetailViewModel {
  func getPlaceInfo() -> PlaceModel {
    place
  }
}
