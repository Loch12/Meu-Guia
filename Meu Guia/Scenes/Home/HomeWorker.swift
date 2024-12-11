import Foundation

protocol HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], ErrorResponse>) -> Void)
}

class HomeWorker: HomeWorkerProtocol {
  func fetchPlaces(completion: @escaping (Result<[PlaceModel], ErrorResponse>) -> Void) {
    let result = true
    switch result {
    case true:
      if let mock = loadMockPlaces() {
        completion(.success(mock))
        return
      }
      completion(.failure(ErrorResponse(error: .unexpected)))
    case false:
      completion(.failure(ErrorResponse(error: .unexpected)))
    }
  }

  func loadMockPlaces() -> [PlaceModel]? {
    guard let url = Bundle.main.url(forResource: "mock", withExtension: "json") else {
      print("JSON file not found")
      return nil
    }

    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let places = try decoder.decode([PlaceModel].self, from: data)
      return places
    } catch {
      print("Error decoding JSON: \(error)")
      return nil
    }
  }
}
