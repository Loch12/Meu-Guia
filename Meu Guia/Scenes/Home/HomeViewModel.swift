import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {
  func redirectToPlaces()
  func redirectToMap()
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
  func redirectToPlaces() {
    coordinator.redirectToPlaces()
  }

  func redirectToMap() {
    coordinator.redirectToMap()
  }
}
