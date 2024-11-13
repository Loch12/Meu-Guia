import Foundation

// MARK: - PlacesListingViewModelProtocol
protocol PlacesListingViewModelProtocol {
  func getHowManyPlaces() -> Int
  func getPlace(by index: Int) -> PlaceModel?
}

// MARK: - PlacesListingViewModel
class PlacesListingViewModel: PlacesListingViewModelProtocol {
  // MARK: - Properties
  let places: [PlaceModel]

  init(places: [PlaceModel]) {
    self.places = places
  }
}

extension PlacesListingViewModel {
  func getHowManyPlaces() -> Int {
    return places.count
  }

  func getPlace(by index: Int) -> PlaceModel? {
    guard index < places.count else { return nil }

    return places[index]
  }
}
