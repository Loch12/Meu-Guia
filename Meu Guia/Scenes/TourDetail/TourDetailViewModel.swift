import Foundation

// MARK: - TourDetailViewModelProtocol
protocol TourDetailViewModelProtocol {
  var isOnline: Bool { get }
  
  func setupDelegate(delegate: TourDetailViewControllerProtocol)
  func getHowManyPlaces() -> Int
  func getPlace(by index: Int) -> PlaceModel?
  func filterPlaces(by text: String)
  func didSelect(at index: IndexPath)
  func getTour() -> TourModel?
  func saveTour() -> Bool
  func deleteTour(completion: @escaping () -> Void)
  func returnToListing()
  func fetchTour()
  func getPlaceholderMessage(isSearching: Bool) -> String?
  func didSelectPlaceholder(isSearching: Bool)
}

// MARK: - TourDetailViewModel
class TourDetailViewModel: TourDetailViewModelProtocol {
  // MARK: - Properties
  var tour: TourModel
  let coordinator: ToursCoordinator
  var controllerDelegate: TourDetailViewControllerProtocol?
  let isOnline: Bool
  let coreDataPersistance: TourPersistenceProtocol
  var filteredPlaces: [PlaceModel] = [] {
    didSet {
      controllerDelegate?.reloadInfo()
    }
  }

  init(tour: TourModel, isOnline: Bool, coordinator: ToursCoordinator) {
    self.tour = tour
    self.filteredPlaces = tour.places ?? []
    self.coordinator = coordinator
    self.isOnline = isOnline
    self.coreDataPersistance = CoreDataTourPersistence()
  }

  func setupDelegate(delegate: TourDetailViewControllerProtocol) {
    self.controllerDelegate = delegate
  }
  
  func fetchTour() {
    guard let id = tour.id,
          !isOnline,
          let updatedTour = coreDataPersistance.fetchTour(by: id) else {
      return
    }
    self.tour = updatedTour
    self.filteredPlaces = tour.places ?? []
  }
}

extension TourDetailViewModel {
  func getHowManyPlaces() -> Int {
    return filteredPlaces.count
  }

  func getPlace(by index: Int) -> PlaceModel? {
    guard index < filteredPlaces.count else { return nil }

    return filteredPlaces[index]
  }

  func filterPlaces(by text: String) {
    guard text.isNotEmpty,
          let places = tour.places else {
      filteredPlaces = tour.places ?? []
      return
    }

    filteredPlaces = places.filter { place in
      guard let name = place.name else { return false }
      return name.containsIgnoringCase(find: text)
    }
  }

  func didSelect(at index: IndexPath) {
    guard index.row < filteredPlaces.count,
          filteredPlaces.count > 0 else { return }

    coordinator.redirectToPlaceDetail(with: filteredPlaces[index.row], of: tour, isOnline: isOnline)
  }

  func getTour() -> TourModel? {
    tour
  }
  
  func saveTour() -> Bool {
    return coreDataPersistance.saveTour(tour, editing: false)
  }
  
  func deleteTour(completion: @escaping () -> Void) {
    guard let id = tour.id else { return }
    coreDataPersistance.deleteTour(by: id)
    completion()
  }
  
  func returnToListing() {
    coordinator.popViewController()
  }
  
  func getPlaceholderMessage(isSearching: Bool) -> String? {
    isSearching ? .emptyPlacesPlaceholder : .savedPlacesPlaceholderMessage
  }
  
  func didSelectPlaceholder(isSearching: Bool) {
    guard !isSearching else { return }
    coordinator.redirectToSaveLocation()
  }
}
