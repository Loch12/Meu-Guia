public import CoreData

@objc(PlaceEntity)
public class PlaceEntity: NSManagedObject {}

extension PlaceEntity {
  func toDomain() -> PlaceModel {
    return PlaceModel(
      id: Int(id),
      name: name,
      description: desc,
      info: nil,
      coordinates: PlaceCoordinates(latitude: latitude, longitude: longitude)
    )
  }
}
