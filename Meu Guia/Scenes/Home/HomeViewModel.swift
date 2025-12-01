import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject {
  func redirectToOnlineTours()
  func redirectToSavedTours()
  func setupDelegate(delegate: BaseViewControllerProtocol)
}

// MARK: - HomeViewModel
class HomeViewModel: HomeViewModelProtocol {
  // MARK: - Properties
  let coordinator: HomeCoordinatorProtocol
  let worker: HomeWorkerProtocol
  var controllerDelegate: BaseViewControllerProtocol?

  init(coordinator: HomeCoordinatorProtocol, worker: HomeWorkerProtocol = HomeWorker()) {
    self.coordinator = coordinator
    self.worker = worker
  }

  func setupDelegate(delegate: BaseViewControllerProtocol) {
    self.controllerDelegate = delegate
  }
}

// MARK: - Methods
extension HomeViewModel {
  func redirectToSavedTours() {
    controllerDelegate?.startLoading()
    worker.fetchTours { [weak self] result in
      guard let self = self else { return }

      self.controllerDelegate?.stopLoading()
      switch result {
      case .success(let tours):
        self.coordinator.redirectToSavedTours(tours: tours)
      case .failure(let error):
        coordinator.showError(error)
      }
    }
  }

  func redirectToOnlineTours() {
    controllerDelegate?.startLoading()
    worker.fetchTours { [weak self] result in
      guard let self = self else { return }

      self.controllerDelegate?.stopLoading()
      switch result {
      case .success(let tours):
        self.coordinator.redirectToSavedTours(tours: tours)
      case .failure(let error):
        coordinator.showError(error)
      }
    }
  }
}
