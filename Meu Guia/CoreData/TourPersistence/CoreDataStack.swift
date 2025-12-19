import CoreData

final class CoreDataStack {

  static let shared = CoreDataStack()

  private init() {}

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TourDataModel")

    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Erro ao carregar Core Data: \(error)")
      }
    }

    return container
  }()

  var context: NSManagedObjectContext {
    persistentContainer.viewContext
  }

  func saveContext() {
    let context = persistentContainer.viewContext
    guard context.hasChanges else { return }

    do {
      try context.save()
    } catch {
      fatalError("Erro ao salvar contexto: \(error)")
    }
  }
}
