public import CoreData

public typealias PlaceEntityCoreDataPropertiesSet = NSSet

extension PlaceEntity {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaceEntity> {
    return NSFetchRequest<PlaceEntity>(entityName: "PlaceEntity")
  }

  @NSManaged public var id: Int64
  @NSManaged public var name: String?
  @NSManaged public var desc: String?
  @NSManaged public var image: String?
  @NSManaged public var latitude: Double
  @NSManaged public var longitude: Double
  @NSManaged public var tour: TourEntity?
  @NSManaged public var infos: Set<PlaceDetailInfoEntity>?
}
