import Foundation

struct TourDetailModel: Codable {
  let name: String?
  let id: Int?
  let description: String?
  let image: String?
  let places: [PlaceModel]?
}
