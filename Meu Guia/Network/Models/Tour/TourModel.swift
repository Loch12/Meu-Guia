import MapKit

struct TourModel: Codable {
  let name: String?
  let id: Int?
  let places: [PlaceModel]?
}
