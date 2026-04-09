import Foundation
import CoreData

protocol TourPersistenceProtocol {
  func saveTour(_ tour: TourModel, editing: Bool) -> Bool
  func fetchTour(by id: Int) -> TourModel?
  func fetchAllTours() -> [TourModel]
  func deleteTour(by id: Int)
}

final class CoreDataTourPersistence: TourPersistenceProtocol {

  private let context: NSManagedObjectContext

  init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
    self.context = context
  }

  func saveTour(_ tour: TourModel, editing: Bool) -> Bool {
    guard let entity = createTourEntity(tour: tour, editing: editing) else { return false }

    if let oldPlaces = entity.places as? Set<PlaceEntity> {
      oldPlaces.forEach { context.delete($0) }
    }

    tour.places?.forEach { place in
      let placeEntity = PlaceEntity(context: context)
      placeEntity.id = Int64(place.id ?? IdGenerator.nextId())
      placeEntity.name = place.name
      placeEntity.desc = place.description
      placeEntity.latitude = place.coordinates?.latitude ?? 0
      placeEntity.longitude = place.coordinates?.longitude ?? 0
      
      if let infos = place.info {
        let infoEntities: [PlaceDetailInfoEntity] = infos.map { info in
          let infoEntity = PlaceDetailInfoEntity(context: context)
          infoEntity.title = info.title
          infoEntity.value = info.value
          infoEntity.infoDescription = info.description
          infoEntity.type = info.type?.rawValue
          infoEntity.place = placeEntity
          
          return infoEntity
        }
        
        placeEntity.infos = Set(infoEntities) as Set<PlaceDetailInfoEntity>
      }
      
      entity.addToPlaces(placeEntity)
    }

    do {
      try context.save()
      return true
    } catch {
      return false
    }
  }
  
  private func createTourEntity(tour: TourModel, editing: Bool) -> TourEntity? {
    guard let tourId = tour.id else { return nil }
    let request: NSFetchRequest<TourEntity> = TourEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %d", tourId)
    request.fetchLimit = 1
    
    let entity: TourEntity
    
    if let existing = try? context.fetch(request).first {
      guard editing else { return nil }
      entity = existing
    } else {
      entity = TourEntity(context: context)
      entity.id = Int64(tourId)
    }
    
    entity.name = tour.name
    entity.isEdited = tour.isEdited ?? false
    
    return entity
  }

  func fetchTour(by id: Int) -> TourModel? {
    let request: NSFetchRequest<TourEntity> = TourEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %d", id)

    guard let entity = try? context.fetch(request).first else {
      return nil
    }

    return entity.toDomain()
  }

  private func fetchTourEntity(by id: Int) -> TourEntity? {
    let request: NSFetchRequest<TourEntity> = TourEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %d", id)
    request.fetchLimit = 1
    return try? context.fetch(request).first
  }

  func deleteTour(by id: Int) {
    let request: NSFetchRequest<TourEntity> = TourEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %d", id)

    if let result = try? context.fetch(request) {
      result.forEach { context.delete($0) }
    }
  }

  func fetchAllTours() -> [TourModel] {
    let request: NSFetchRequest<TourEntity> = TourEntity.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "name", ascending: true)
    ]

    do {
      let result = try context.fetch(request)
      return result.map { $0.toDomain() }
    } catch {
      return []
    }
  }
}
