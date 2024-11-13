import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject {
  func redirectToPlaces()
  func redirectToMap()
  func setupDelegate(delegate: HomeViewControllerProtocol)
}

// MARK: - HomeViewModel
class HomeViewModel: HomeViewModelProtocol {
  // MARK: - Properties
  let coordinator: HomeCoordinatorProtocol
  let worker: HomeWorkerProtocol
  var controllerDelegate: HomeViewControllerProtocol?

  init(coordinator: HomeCoordinatorProtocol, worker: HomeWorkerProtocol = HomeWorker()) {
    self.coordinator = coordinator
    self.worker = worker
  }

  func setupDelegate(delegate: HomeViewControllerProtocol) {
    self.controllerDelegate = delegate
  }
}

// MARK: - Methods
extension HomeViewModel {
  func redirectToPlaces() {
    controllerDelegate?.startLoading()
    worker.fetchPlaces { [weak self] result in
      guard let self = self else { return }

      self.controllerDelegate?.stopLoading()
      switch result {
      case .success(let places):
        self.coordinator.redirectToPlaces(places: places)
      case .failure(let error):
        coordinator.showError(error)
      }
    }
  }

  func redirectToMap() {
    controllerDelegate?.startLoading()
    worker.fetchPlaces { [weak self] result in
      guard let self = self else { return }

      self.controllerDelegate?.stopLoading()
      switch result {
      case .success(let places):
        self.coordinator.redirectToMap(places: places)
      case .failure(let error):
        coordinator.showError(error)
      }
    }
  }
}
