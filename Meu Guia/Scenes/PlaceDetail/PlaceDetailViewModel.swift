import Foundation

// MARK: - PlaceDetailViewModelProtocol
protocol PlaceDetailViewModelProtocol {
  var place: PlaceDetailModel? { get set }

  func fetchPlaceDetail()
  func setControllerDelegate(_ delegate: PlaceDetailViewControllerProtocol)
}

// MARK: - PlaceDetailViewModel
class PlaceDetailViewModel: PlaceDetailViewModelProtocol {
  // MARK: - Properties
  let id: Int
  let worker: PlaceDetailWorkerProtocol
  var controllerDelegate: PlaceDetailViewControllerProtocol?
  var place: PlaceDetailModel?
  let coordinator: ToursCoordinator

  init(id: Int, coordinator: ToursCoordinator, worker: PlaceDetailWorkerProtocol = PlaceDetailWorker()) {
    self.id = id
    self.worker = worker
    self.coordinator = coordinator
  }

  func setControllerDelegate(_ delegate: PlaceDetailViewControllerProtocol) {
    self.controllerDelegate = delegate
  }
}

extension PlaceDetailViewModel {
  func fetchPlaceDetail() {
    controllerDelegate?.startLoading()
    worker.fetchPlaceDetail(id: id) { [weak self] result in
      guard let self = self else { return }

      self.controllerDelegate?.stopLoading()
      switch result {
      case .success(let place):
        self.place = place
        self.controllerDelegate?.reloadInfo()
      case .failure(let error):
        coordinator.showError(error)
      }
    }
  }
}
