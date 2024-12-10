import Foundation

protocol HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], ErrorResponse>) -> Void)
}

class HomeWorker: HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], ErrorResponse>) -> Void) {
    let result = true
    switch result {
    case true:
      completion(.success([PlaceModel(name: "Sugrad", image: "Teste", description: "Teste", site: "Teste", phone: "27995325877", schedule: "Teste"),
                           PlaceModel(name: "Cantina", image: "Teste", description: "Teste", site: "Teste", phone: "Teste", schedule: "Teste"),
                           PlaceModel(name: "RU", image: "Teste", description: "Teste", site: "Teste", phone: "Teste", schedule: "Teste")]))
    case false:
      completion(.failure(ErrorResponse(error: .unexpected)))
    }
  }
}
