import Foundation

// MARK: - PlacesMapViewModelProtocol
protocol PlacesMapViewModelProtocol {
  var places: [PlaceModel] { get }

  func redirectToDetail(place: PlaceModel)
}

// MARK: - PlacesMapViewModel
class PlacesMapViewModel: PlacesMapViewModelProtocol {
  // MARK: - Properties
  let coordinator: PlacesMapCoordinator
  let places: [PlaceModel]

  init(coordinator: PlacesMapCoordinator, places: [PlaceModel]) {
    self.coordinator = coordinator
    self.places = places
  }
}

extension PlacesMapViewModel {
  func redirectToDetail(place: PlaceModel) {
    coordinator.redirectTo(place: place)
  }
}
