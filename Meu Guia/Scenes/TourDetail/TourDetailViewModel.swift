import Foundation

// MARK: - TourDetailViewModelProtocol
protocol TourDetailViewModelProtocol {
  func setupDelegate(delegate: TourDetailViewControllerProtocol)
  func getHowManyPlaces() -> Int
  func getPlace(by index: Int) -> PlaceModel?
  func filterPlaces(by text: String)
  func didSelect(at index: IndexPath)
  func fetchTourDetail()
}

// MARK: - TourDetailViewModel
class TourDetailViewModel: TourDetailViewModelProtocol {
  // MARK: - Properties
  let id: Int
  var tour: TourDetailModel?
  let coordinator: ToursCoordinator
  let worker: TourDetailWorkerProtocol
  var controllerDelegate: TourDetailViewControllerProtocol?
  var filteredPlaces: [PlaceModel] = [] {
    didSet {
      controllerDelegate?.reloadInfo()
    }
  }

  init(id: Int, coordinator: ToursCoordinator, worker: TourDetailWorkerProtocol = TourDetailWorker()) {
    self.id = id
    self.coordinator = coordinator
    self.worker = worker
  }

  func setupDelegate(delegate: TourDetailViewControllerProtocol) {
    self.controllerDelegate = delegate
  }
}

extension TourDetailViewModel {
  func fetchTourDetail() {
    controllerDelegate?.startLoading()
    worker.fetchTourDetail(id: id) { [weak self] result in
      guard let self = self else { return }

      self.controllerDelegate?.stopLoading()
      switch result {
      case .success(let tour):
        self.tour = tour
        self.filteredPlaces = tour.places ?? []
        self.controllerDelegate?.reloadInfo()
      case .failure(let error):
        coordinator.showError(error)
      }
    }
  }

  func getHowManyPlaces() -> Int {
    return filteredPlaces.count
  }

  func getPlace(by index: Int) -> PlaceModel? {
    guard index < filteredPlaces.count else { return nil }

    return filteredPlaces[index]
  }

  func filterPlaces(by text: String) {
    guard text.isNotEmpty,
          let places = tour?.places else {
      filteredPlaces = tour?.places ?? []
      return
    }

    filteredPlaces = places.filter { place in
      guard let name = place.name else { return false }
      return name.containsIgnoringCase(find: text)
    }
  }

  func didSelect(at index: IndexPath) {
    guard index.row < filteredPlaces.count,
          let id = filteredPlaces[index.row].id else { return }

    coordinator.redirectToPlaceDetail(with: id)
  }
}
