public import Foundation
public import CoreData

public typealias TourEntityCoreDataPropertiesSet = NSSet

extension TourEntity {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<TourEntity> {
    return NSFetchRequest<TourEntity>(entityName: "TourEntity")
  }

  @NSManaged public var id: Int64
  @NSManaged public var name: String?
  @NSManaged public var places: NSSet?
  @NSManaged public var isEdited: Bool
}

// MARK: Generated accessors for places
extension TourEntity {

  @objc(addPlacesObject:)
  @NSManaged public func addToPlaces(_ value: PlaceEntity)

  @objc(removePlacesObject:)
  @NSManaged public func removeFromPlaces(_ value: PlaceEntity)

  @objc(addPlaces:)
  @NSManaged public func addToPlaces(_ values: NSSet)

  @objc(removePlaces:)
  @NSManaged public func removeFromPlaces(_ values: NSSet)

}
