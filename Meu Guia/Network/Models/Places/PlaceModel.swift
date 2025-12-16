import MapKit

struct PlaceModel: Codable {
  let name: String?
  let image: String?
  let description: String?
  let info: [PlaceDetailInfo]?
  let coordinates: PlaceCoordinates?
}

struct PlaceDetailInfo: Codable {
  let title: String?
  let value: String?
  let description: String?
  let type: InfoType?
}

enum InfoType: String, Codable {
  case text
  case phone
  case link
  case other
}

extension InfoType {
  public init(from decoder: Decoder) throws {
    self = try InfoType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .other
  }
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
