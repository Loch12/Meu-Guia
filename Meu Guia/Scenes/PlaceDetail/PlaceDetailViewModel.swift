import Foundation

// MARK: - PlaceDetailViewModelProtocol
protocol PlaceDetailViewModelProtocol: AnyObject {
  var isOnline: Bool { get }
  
  func getPlaceInfo() -> PlaceModel
  func startNavigation()
  func editPlace()
}

// MARK: - PlaceDetailViewModel
class PlaceDetailViewModel: PlaceDetailViewModelProtocol {
  // MARK: - Properties
  let place: PlaceModel
  let tour: TourModel
  let coordinator: ToursCoordinator
  let isOnline: Bool

  init(place: PlaceModel, tour: TourModel, isOnline: Bool, coordinator: ToursCoordinator) {
    self.place = place
    self.tour = tour
    self.coordinator = coordinator
    self.isOnline = isOnline
  }
}

extension PlaceDetailViewModel {
  func getPlaceInfo() -> PlaceModel {
    place
  }
  
  func startNavigation() {
    coordinator.redirectToNavigation(with: place)
  }
  
  func editPlace() {
    coordinator.redirectToEditPlace(with: place, of: tour)
  }
}
