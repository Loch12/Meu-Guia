import Foundation

// MARK: - OnlineToursViewModel
class OnlineToursViewModel: ToursListingViewModelProtocol {
  // MARK: - Properties
  let coordinator: ToursCoordinator
  let tours: [TourModel]
  var delegate: ToursListingViewControllerProtocol?
  var filteredTours: [TourModel] {
    didSet {
      delegate?.reloadInfo()
    }
  }

  init(coordinator: ToursCoordinator, tours: [TourModel]) {
    self.coordinator = coordinator
    self.tours = tours
    self.filteredTours = tours
  }

  func setupDelegate(delegate: ToursListingViewControllerProtocol) {
    self.delegate = delegate
  }
}

extension OnlineToursViewModel {
  func getHowManyTours() -> Int {
    return filteredTours.count
  }

  func getTour(by index: Int) -> TourModel? {
    guard index < filteredTours.count else { return nil }

    return filteredTours[index]
  }

  func filterTours(by text: String) {
    guard text.isNotEmpty else {
      filteredTours = tours
      return
    }

    filteredTours = tours.filter { place in
      guard let name = place.name else { return false }
      return name.containsIgnoringCase(find: text)
    }
  }

  func didSelect(at index: IndexPath) {
    guard index.row < filteredTours.count,
          let id = filteredTours[index.row].id else { return }

    coordinator.redirectToTour(with: id)
  }
}
