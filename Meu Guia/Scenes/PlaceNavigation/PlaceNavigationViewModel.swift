import Foundation
import CoreLocation

// MARK: - PlaceNavigationViewModelProtocol
protocol PlaceNavigationViewModelProtocol: AnyObject {
  func getCoordinates() -> CLLocationCoordinate2D?
}

// MARK: - PlaceNavigationViewModel
class PlaceNavigationViewModel: PlaceNavigationViewModelProtocol {
  // MARK: - Properties
  let place: PlaceModel
  let coordinator: ToursCoordinator

  init(place: PlaceModel, coordinator: ToursCoordinator) {
    self.place = place
    self.coordinator = coordinator
  }
  
  func getCoordinates() -> CLLocationCoordinate2D? {
    guard let latitude = place.coordinates?.latitude,
          let longitude = place.coordinates?.longitude else { return nil }
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
