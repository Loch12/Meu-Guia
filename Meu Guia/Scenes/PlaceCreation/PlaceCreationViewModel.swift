import Foundation

// MARK: - PlaceCreationViewModelProtocol
protocol PlaceCreationViewModelProtocol: AnyObject {
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void)
  func returnToMenu()
  func savePlace(place: PlaceModel)
}

// MARK: - PlaceCreationViewModel
class PlaceCreationViewModel: PlaceCreationViewModelProtocol {
  // MARK: - Properties
  let coordinator: PlaceCreationCoordinator
  let coreDataPersistance: TourPersistenceProtocol

  init(coordinator: PlaceCreationCoordinator) {
    self.coordinator = coordinator
    self.coreDataPersistance = CoreDataTourPersistence()
  }
  
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void) {
    coordinator.presentCustomFieldCreation { result in
      completion(result)
    }
  }
  
  func returnToMenu() {
    coordinator.popViewController()
  }
  
  func savePlace(place: PlaceModel) {
    coordinator.redirectToTourSelection(place: place)
  }
}
