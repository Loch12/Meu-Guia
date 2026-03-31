public import CoreData

@objc(PlaceEntity)
public class PlaceEntity: NSManagedObject {}

extension PlaceEntity {
  func toDomain() -> PlaceModel {
    let infosArray = (infos)?.map {
      $0.toDomain()
    }
    
    return PlaceModel(
      id: Int(id),
      name: name,
      description: desc,
      info: infosArray,
      coordinates: PlaceCoordinates(latitude: latitude, longitude: longitude)
    )
  }
}

extension PlaceDetailInfoEntity {
  func toDomain() -> PlaceDetailInfo {
    return PlaceDetailInfo(
      title: title,
      value: value,
      description: infoDescription,
      type: InfoType(rawValue: type ?? "")
    )
  }
}
