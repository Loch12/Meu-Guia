import Foundation

// MARK: - EditingTourViewModel
class EditingTourViewModel: ToursListingViewModelProtocol {
  // MARK: - Properties
  let placeToSave: PlaceModel?
  let isOnline = false
  let coordinator: PlaceCreationCoordinator
  var tours: [TourModel] = []
  var delegate: ToursListingViewControllerProtocol?
  let coreDataPersitance: TourPersistenceProtocol
  var filteredTours: [TourModel] = [] {
    didSet {
      delegate?.reloadInfo()
    }
  }

  init(place: PlaceModel, coordinator: PlaceCreationCoordinator) {
    self.placeToSave = place
    self.coordinator = coordinator
    self.coreDataPersitance = CoreDataTourPersistence()
  }
}

extension EditingTourViewModel {
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
    guard index.row < filteredTours.count,
          let placeToSave else { return }

    var places = filteredTours[index.row].places
    places?.append(placeToSave)
    let tour = TourModel(name: filteredTours[index.row].name,
                         id: filteredTours[index.row].id,
                         places: places,
                         isEdited: true)
    guard coreDataPersitance.saveTour(tour, editing: true) else {
      return
    }
    coordinator.popToRootViewController()
  }

  func setupDelegate(delegate: ToursListingViewControllerProtocol) {
    self.delegate = delegate
  }
  
  func didSelectPlaceholder() {
    createTour()
  }
  
  func createTour() {
    guard let placeToSave else { return }
    coordinator.presentTourCreation { tour in
      guard let tour else { return }
      _ = self.coreDataPersitance.saveTour(TourModel(name: tour.name,
                                                     id: tour.id,
                                                     places: [placeToSave],
                                                     isEdited: tour.isEdited),
                                           editing: false)
      self.coordinator.redirectToToursListing()
    }
  }
  
  func getPlaceholderMessage(isSearching: Bool) -> String? {
    isSearching ? .onlineToursPlaceholderMessage : .editingToursPlaceholderMessage
  }
}
