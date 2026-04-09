import Foundation

// MARK: - PlaceEditViewModelProtocol
protocol PlaceEditViewModelProtocol: AnyObject {
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void)
  func getPlace() -> PlaceModel
  func save(_ newPlace: PlaceModel) -> Bool
  func returnView()
}

// MARK: - PlaceEditViewModel
class PlaceEditViewModel: PlaceEditViewModelProtocol {
  // MARK: - Properties
  let coordinator: ToursCoordinator
  let place: PlaceModel
  let tour: TourModel
  let coreDataPersistance: TourPersistenceProtocol

  init(place: PlaceModel, tour: TourModel, coordinator: ToursCoordinator) {
    self.coordinator = coordinator
    self.place = place
    self.tour = tour
    self.coreDataPersistance = CoreDataTourPersistence()
  }
  
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void) {
    coordinator.presentCustomFieldCreation { result in
      completion(result)
    }
  }
  
  func getPlace() -> PlaceModel {
    place
  }
  
  func save(_ newPlace: PlaceModel) -> Bool {
    guard let places = tour.places else { return false }
    
    let updatedPlaces = places.map { place in
      if place.id == newPlace.id {
        return newPlace
      }
      return place
    }
    
    return coreDataPersistance.saveTour(TourModel(name: tour.name,
                                                  id: tour.id,
                                                  places: updatedPlaces,
                                                  isEdited: true),
                                        editing: true)
  }
  
  func returnView() {
    coordinator.popViewController()
  }
}
