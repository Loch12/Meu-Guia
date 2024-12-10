import Foundation

// MARK: - PlaceDetailViewModelProtocol
protocol PlaceDetailViewModelProtocol {
  var place: PlaceModel { get }
}

// MARK: - PlaceDetailViewModel
class PlaceDetailViewModel: PlaceDetailViewModelProtocol {
  // MARK: - Properties
  let place: PlaceModel

  init(place: PlaceModel) {
    self.place = place
  }
}

extension PlaceDetailViewModel {

}
