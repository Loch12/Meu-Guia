import UIKit

// MARK: - ToursListingViewModelProtocol
protocol ToursListingViewModelProtocol {
  func getHowManyTours() -> Int
  func getTour(by index: Int) -> TourModel?
  func filterTours(by text: String)
  func didSelect(at index: IndexPath)
}
