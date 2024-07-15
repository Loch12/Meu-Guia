import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {

}

// MARK: - HomeViewModel
class HomeViewModel: HomeViewModelProtocol {
  // MARK: - Properties
  let coordinator: HomeCoordinatorProtocol

  init(coordinator: HomeCoordinatorProtocol) {
    self.coordinator = coordinator
  }
}
