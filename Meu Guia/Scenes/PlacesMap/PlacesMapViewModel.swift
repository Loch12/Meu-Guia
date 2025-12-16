import Foundation

// MARK: - PlacesMapViewModelProtocol
protocol PlacesMapViewModelProtocol {
  var places: [PlaceModel] { get }

  func redirectToDetail(place: PlaceModel)
}

// MARK: - PlacesMapViewModel
class PlacesMapViewModel: PlacesMapViewModelProtocol {
  // MARK: - Properties
  let places: [PlaceModel]

  init(places: [PlaceModel]) {
    self.places = places
  }
}

extension PlacesMapViewModel {
  func redirectToDetail(place: PlaceModel) {

  }
}
