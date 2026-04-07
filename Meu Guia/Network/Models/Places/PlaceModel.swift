import MapKit
import CoreData

struct PlaceModel: Codable {
  let id: Int?
  let name: String?
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

extension PlaceModel {
  func toEntity(context: NSManagedObjectContext) -> PlaceEntity {
    let entity = PlaceEntity(context: context)
    
    entity.id = Int64(id ?? 0)
    entity.name = name
    entity.desc = description
    entity.latitude = coordinates?.latitude ?? 0
    entity.longitude = coordinates?.longitude ?? 0
    
    if let infos = info {
      let infoEntities = infos.map { $0.toEntity(context: context) }
      entity.infos = Set(infoEntities) as Set<PlaceDetailInfoEntity>
    }
    
    return entity
  }
}

extension PlaceDetailInfo {
  func toEntity(context: NSManagedObjectContext) -> PlaceDetailInfoEntity {
    let entity = PlaceDetailInfoEntity(context: context)
    
    entity.title = title
    entity.value = value
    entity.infoDescription = description
    entity.type = type?.rawValue
    
    return entity
  }
}

class IdGenerator {
  private static var currentId: Int = 0
  
  static func nextId() -> Int {
    currentId += 1
    return currentId
  }
}
