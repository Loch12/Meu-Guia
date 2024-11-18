import Foundation

protocol HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], ErrorResponse>) -> Void)
}

class HomeWorker: HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], ErrorResponse>) -> Void) {
    let result = true
    switch result {
    case true:
      completion(.success([PlaceModel(name: "Lugar teste", image: "Teste", description: "Teste"),
                           PlaceModel(name: "1", image: "Teste", description: "Teste"),
                           PlaceModel(name: "2", image: "Teste", description: "Teste"),
                           PlaceModel(name: "3", image: "Teste", description: "Teste"),
                           PlaceModel(name: "perigo", image: "Teste", description: "Teste"),
                           PlaceModel(name: "sem", image: "Teste", description: "Teste"),
                           PlaceModel(name: "      ", image: "Teste", description: "Teste"),
                           PlaceModel(name: "lugar", image: "Teste", description: "Teste")]))
    case false:
      completion(.failure(ErrorResponse(error: .unexpected)))
    }
  }
}
