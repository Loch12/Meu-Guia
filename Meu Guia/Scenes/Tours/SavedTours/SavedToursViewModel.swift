import Foundation

// MARK: - SavedToursViewModel
class SavedToursViewModel: ToursListingViewModelProtocol {
  // MARK: - Properties
  let placeToSave: PlaceModel? = nil
  let isOnline = false
  let coordinator: ToursCoordinator
  var tours: [TourModel] = []
  var delegate: ToursListingViewControllerProtocol?
  let coreDataPersitance: TourPersistenceProtocol
  var filteredTours: [TourModel] = [] {
    didSet {
      delegate?.reloadInfo()
    }
  }

  init(coordinator: ToursCoordinator) {
    self.coordinator = coordinator
    self.coreDataPersitance = CoreDataTourPersistence()
  }
}

extension SavedToursViewModel {
  func fetchTours() {
    tours = coreDataPersitance.fetchAllTours()
    filteredTours = tours
    delegate?.reloadInfo()
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
    coordinator.redirectToOnlineTours()
  }
  
  func getPlaceholderMessage(isSearching: Bool) -> String? {
    isSearching ? .onlineToursPlaceholderMessage : .savedToursPlaceholderMessage
  }
}
