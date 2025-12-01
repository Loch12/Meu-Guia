import Foundation

protocol HomeWorkerProtocol {
  func fetchTours(completion: @escaping (Result<[TourModel], ErrorResponse>) -> Void)
}

class HomeWorker: HomeWorkerProtocol {
  func fetchTours(completion: @escaping (Result<[TourModel], ErrorResponse>) -> Void) {
    let result = true
    switch result {
    case true:
      if let mock = loadMockTours() {
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

  func loadMockTours() -> [TourModel]? {
    return []
  }
}
