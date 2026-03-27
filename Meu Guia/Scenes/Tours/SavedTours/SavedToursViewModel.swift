import Foundation

// MARK: - SavedToursViewModel
class SavedToursViewModel: ToursListingViewModelProtocol {
  // MARK: - Properties
  let isOnline = false
  let coordinator: ToursCoordinator
  let tours: [TourModel]
  var delegate: ToursListingViewControllerProtocol?
  let worker: HomeWorkerProtocol
  var filteredTours: [TourModel] {
    didSet {
      delegate?.reloadInfo()
    }
  }

  init(coordinator: ToursCoordinator, tours: [TourModel], worker: HomeWorkerProtocol = HomeWorker()) {
    self.coordinator = coordinator
    self.tours = tours
    self.filteredTours = tours
    self.worker = worker
  }
}

extension SavedToursViewModel {
  func getHowManyTours() -> Int {
    return filteredTours.count
  }

  func getTour(by index: Int) -> TourModel? {
    guard index < filteredTours.count,
          filteredTours.count > 0 else { return nil }

    return filteredTours[index]
  }

  func filterTours(by text: String) {
    guard text.isNotEmpty else {
      filteredTours = tours
      return
    }

    filteredTours = tours.filter { tour in
      guard let name = tour.name else { return false }
      return name.containsIgnoringCase(find: text)
    }
  }

  func didSelect(at index: IndexPath) {
    guard index.row < filteredTours.count,
          let id = filteredTours[index.row].id else { return }

    coordinator.redirectToTour(with: id)
  }

  func setupDelegate(delegate: ToursListingViewControllerProtocol) {
    self.delegate = delegate
  }
  
  func didSelectPlaceholder() {
    delegate?.startLoading()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.worker.fetchTours { [weak self] result in
        guard let self = self else { return }
        
        self.delegate?.stopLoading()
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
