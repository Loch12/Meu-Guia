import Foundation

protocol OnlineToursWorkerProtocol {
  func fetchTours(completion: @escaping (Result<[TourModel], ErrorResponse>) -> Void)
}

class OnlineToursWorker: OnlineToursWorkerProtocol {
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

  func loadMockTours() -> [TourModel]? {
    guard let url = Bundle.main.url(forResource: "mockTours", withExtension: "json") else {
      print("JSON file not found")
      return nil
    }

    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let places = try decoder.decode([TourModel].self, from: data)
      return places
    } catch {
      print("Error decoding JSON: \(error)")
      return nil
    }
  }
}
