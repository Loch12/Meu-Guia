import UIKit

// MARK: - ToursListingViewModelProtocol
protocol ToursListingViewModelProtocol {
  var placeToSave: PlaceModel? { get }
  func getHowManyTours() -> Int
  func getTour(by index: Int) -> TourModel?
  func filterTours(by text: String)
  func didSelect(at index: IndexPath)
  func didSelectPlaceholder()
  func setupDelegate(delegate: ToursListingViewControllerProtocol)
  func fetchTours()
  func getPlaceholderMessage(isSearching: Bool) -> String?
}
