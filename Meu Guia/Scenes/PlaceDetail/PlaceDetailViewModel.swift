import Foundation
import CoreLocation

// MARK: - PlaceDetailViewModelProtocol
protocol PlaceDetailViewModelProtocol: AnyObject {
  var isOnline: Bool { get }
  
  func getPlaceInfo() -> PlaceModel
  func editPlace()
  func returnToListing()
  func deletePlace(completion: @escaping (Bool) -> Void)
  func fetchPlace()
  func getCoordinates() -> CLLocationCoordinate2D?
}

// MARK: - PlaceDetailViewModel
class PlaceDetailViewModel: PlaceDetailViewModelProtocol {
  // MARK: - Properties
  var place: PlaceModel
  var tour: TourModel
  let coordinator: ToursCoordinator
  let isOnline: Bool
  let coreDataPersistance: TourPersistenceProtocol

  init(place: PlaceModel, tour: TourModel, isOnline: Bool, coordinator: ToursCoordinator) {
    self.place = place
    self.tour = tour
    self.coordinator = coordinator
    self.isOnline = isOnline
    self.coreDataPersistance = CoreDataTourPersistence()
  }
  
  func fetchPlace() {
    guard !isOnline,
          let updatedTour = coreDataPersistance.fetchTour(by: tour.id) else {
      return
    }
    self.tour = updatedTour
    self.place = tour.places?.first { $0.id == place.id } ?? place
  }
}

extension PlaceDetailViewModel {
  func getPlaceInfo() -> PlaceModel {
    place
  }
  
  func editPlace() {
    coordinator.redirectToEditPlace(with: place, of: tour)
  }
  
  func returnToListing() {
    coordinator.popViewController()
  }
  
  func deletePlace(completion: @escaping (Bool) -> Void) {
    let updatedPlaces = tour.places?.filter { $0.id != place.id }
    
    let updatedTour = TourModel(name: tour.name,
                                id: tour.id,
                                places: updatedPlaces,
                                isEdited: true)
    completion(coreDataPersistance.saveTour(updatedTour, editing: true))
  }
  
  func getCoordinates() -> CLLocationCoordinate2D? {
    guard let latitude = place.coordinates?.latitude,
          let longitude = place.coordinates?.longitude else { return nil }
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
