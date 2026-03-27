import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject {
  func redirectToOnlineTours()
  func redirectToSavedTours()
  func redirectToSaveLocation()
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
    let persistence = CoreDataTourPersistence()
    let tours = persistence.fetchAllTours()

    coordinator.redirectToSavedTours(tours: tours)
  }
  
  func redirectToSaveLocation() {
    coordinator.redirectToSaveLocation()
  }

  func redirectToOnlineTours() {
    controllerDelegate?.startLoading()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.worker.fetchTours { [weak self] result in
        guard let self = self else { return }

        self.controllerDelegate?.stopLoading()
        switch result {
        case .success(let tours):
          self.coordinator.redirectToOnlineTours(tours: tours)
        case .failure(let error):
          coordinator.showError(error)
        }
      }
    }
  }
}
