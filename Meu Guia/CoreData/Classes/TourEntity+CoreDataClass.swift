public import CoreData

@objc(TourEntity)
public class TourEntity: NSManagedObject {}

extension TourEntity {
  func toDomain() -> TourModel {
    return TourModel(
      name: name,
      id: Int(id),
      places: places?.allObjects.compactMap { place in
        guard let place = place as? PlaceEntity else { return nil }
        return place.toDomain()
      }
    )
  }
}
