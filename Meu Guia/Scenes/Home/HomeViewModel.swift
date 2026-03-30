import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject {
  func redirectToOnlineTours()
  func redirectToSavedTours()
  func redirectToSaveLocation()
}

// MARK: - HomeViewModel
class HomeViewModel: HomeViewModelProtocol {
  // MARK: - Properties
  let coordinator: HomeCoordinatorProtocol

  init(coordinator: HomeCoordinatorProtocol) {
    self.coordinator = coordinator
  }
}

// MARK: - Methods
extension HomeViewModel {
  func redirectToSavedTours() {
    coordinator.redirectToSavedTours()
  }
  
  func redirectToSaveLocation() {
    coordinator.redirectToSaveLocation()
  }

  func redirectToOnlineTours() {
    coordinator.redirectToOnlineTours()
  }
}
