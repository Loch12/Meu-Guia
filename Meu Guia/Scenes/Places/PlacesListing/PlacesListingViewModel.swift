import Foundation

// MARK: - PlacesListingViewModelProtocol
protocol PlacesListingViewModelProtocol {
  func setupDelegate(delegate: PlacesListingViewControllerProtocol)
  func getHowManyPlaces() -> Int
  func getPlace(by index: Int) -> PlaceModel?
  func filterPlaces(by text: String)
  func didSelect(at index: IndexPath)
}

// MARK: - PlacesListingViewModel
class PlacesListingViewModel: PlacesListingViewModelProtocol {
  // MARK: - Properties
  let coordinator: PlacesCoordinator
  let places: [PlaceModel]
  var delegate: PlacesListingViewControllerProtocol?
  var filteredPlaces: [PlaceModel] {
    didSet {
      delegate?.reloadInfo()
    }
  }

  init(coordinator: PlacesCoordinator, places: [PlaceModel]) {
    self.coordinator = coordinator
    self.places = places
    self.filteredPlaces = places
  }

  func setupDelegate(delegate: PlacesListingViewControllerProtocol) {
    self.delegate = delegate
  }
}

extension PlacesListingViewModel {
  func getHowManyPlaces() -> Int {
    return filteredPlaces.count
  }

  func getPlace(by index: Int) -> PlaceModel? {
    guard index < filteredPlaces.count else { return nil }

    return filteredPlaces[index]
  }

  func filterPlaces(by text: String) {
    guard text.isNotEmpty else {
      filteredPlaces = places
      return
    }

    filteredPlaces = places.filter { place in
      guard let name = place.name else { return false }
      return name.containsIgnoringCase(find: text)
    }
  }

  func didSelect(at index: IndexPath) {
    guard index.row < filteredPlaces.count else { return }

    coordinator.redirectTo(place: filteredPlaces[index.row])
  }
}
