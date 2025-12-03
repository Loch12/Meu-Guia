import MapKit

struct PlaceDetailModel: Codable {
  let name: String?
  let image: String?
  let description: String?
  let site: String?
  let phone: String?
  let schedule: String?
  let coordinates: PlaceCoordinates?
}

struct PlaceCoordinates: Codable {
  let latitude: Double?
  let longitude: Double?

  func getAddressLocation() -> CLLocation? {
    guard let longitude = self.longitude,
          let latitude = self.latitude else { return nil }

    return CLLocation(latitude: latitude, longitude: longitude)
  }
}
