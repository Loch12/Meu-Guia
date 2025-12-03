import Foundation

// MARK: - PlacesMapViewModelProtocol
protocol PlacesMapViewModelProtocol {
  var places: [PlaceDetailModel] { get }

  func redirectToDetail(place: PlaceDetailModel)
}

// MARK: - PlacesMapViewModel
class PlacesMapViewModel: PlacesMapViewModelProtocol {
  // MARK: - Properties
  let places: [PlaceDetailModel]

  init(places: [PlaceDetailModel]) {
    self.places = places
  }
}

extension PlacesMapViewModel {
  func redirectToDetail(place: PlaceDetailModel) {

  }
}
