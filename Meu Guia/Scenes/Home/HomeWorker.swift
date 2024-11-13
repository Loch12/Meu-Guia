import Foundation

protocol HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], Error>) -> Void)
}

class HomeWorker: HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], Error>) -> Void) {
    let result = true
    switch result {
      case true:
        completion(.success([PlaceModel(name: "Teste", image: "Teste", description: "Teste")]))
      case false:
        completion(.failure(Error()))
    }
  }
}
