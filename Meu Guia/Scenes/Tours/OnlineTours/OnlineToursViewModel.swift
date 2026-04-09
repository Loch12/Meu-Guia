import Foundation

// MARK: - OnlineToursViewModel
class OnlineToursViewModel: ToursListingViewModelProtocol {
  // MARK: - Properties
  let placeToSave: PlaceModel? = nil
  let isOnline = true
  let coordinator: ToursCoordinator
  var tours: [TourModel] = []
  var delegate: ToursListingViewControllerProtocol?
  let worker: OnlineToursWorkerProtocol
  var filteredTours: [TourModel] = [] {
    didSet {
      delegate?.reloadInfo()
    }
  }
  
  init(coordinator: ToursCoordinator, worker: OnlineToursWorkerProtocol = OnlineToursWorker()) {
    self.coordinator = coordinator
    self.worker = worker
  }
}

extension OnlineToursViewModel {
  func fetchTours() {
    delegate?.startLoading()
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.worker.fetchTours { [weak self] result in
        guard let self = self else { return }
        
        self.delegate?.stopLoading()
        switch result {
        case .success(let tours):
          self.tours = tours
          self.filteredTours = tours
          self.delegate?.reloadInfo()
        case .failure(let error):
          coordinator.showError(error)
        }
      }
    }
  }
  
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
    guard index.row < filteredTours.count else { return }
    
    coordinator.redirectToTour(with: filteredTours[index.row], isOnline: isOnline)
  }
  
  func setupDelegate(delegate: ToursListingViewControllerProtocol) {
    self.delegate = delegate
  }
  
  func didSelectPlaceholder() {
    
  }
  
  func getPlaceholderMessage(isSearching: Bool) -> String? {
    .onlineToursPlaceholderMessage
  }
}
