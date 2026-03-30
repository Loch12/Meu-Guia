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
}

// MARK: - TourDetailViewModel
class TourDetailViewModel: TourDetailViewModelProtocol {
  // MARK: - Properties
  let tour: TourModel
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

    coordinator.redirectToPlaceDetail(place: filteredPlaces[index.row], isOnline: isOnline)
  }

  func getTour() -> TourModel? {
    tour
  }
  
  func saveTour() -> Bool {
    return coreDataPersistance.saveTour(tour)
  }
  
  func deleteTour(completion: @escaping () -> Void) {
    guard let id = tour.id else { return }
    coreDataPersistance.deleteTour(by: id)
    completion()
  }
  
  func returnToListing() {
    coordinator.popViewController()
  }
}
