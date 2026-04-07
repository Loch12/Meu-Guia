import Foundation

// MARK: - PlaceCreationViewModelProtocol
protocol PlaceCreationViewModelProtocol: AnyObject {
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void)
  func returnToMenu()
}

// MARK: - PlaceCreationViewModel
class PlaceCreationViewModel: PlaceCreationViewModelProtocol {
  // MARK: - Properties
  let coordinator: PlaceCreationCoordinator

  init(coordinator: PlaceCreationCoordinator) {
    self.coordinator = coordinator
  }
  
  func presentCustomFieldCreation(completion: @escaping (PlaceDetailInfo?) -> Void) {
    coordinator.presentCustomFieldCreation { result in
      completion(result)
    }
  }
  
  func returnToMenu() {
    coordinator.popViewController()
  }
}
