import MapKit

struct TourModel: Codable {
  let name: String?
  let id: UUID
  let places: [PlaceModel]?
  let isEdited: Bool?
}
