import Foundation

protocol TourDetailWorkerProtocol {
  func fetchTourDetail(id: Int, completion: @escaping (Result<TourDetailModel, ErrorResponse>) -> Void)
}

class TourDetailWorker: TourDetailWorkerProtocol {
  func fetchTourDetail(id: Int, completion: @escaping (Result<TourDetailModel, ErrorResponse>) -> Void) {
    let result = true
    switch result {
    case true:
      if let mock = loadMockTour() {
        completion(.success(mock))
        return
      }
      completion(.failure(ErrorResponse(error: .unexpected)))
    case false:
      completion(.failure(ErrorResponse(error: .unexpected)))
    }
  }

  func loadMockTour() -> TourDetailModel? {
    guard let url = Bundle.main.url(forResource: "mockTour", withExtension: "json") else {
      print("JSON file not found")
      return nil
    }

    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let places = try decoder.decode(TourDetailModel.self, from: data)
      return places
    } catch {
      print("Error decoding JSON: \(error)")
      return nil
    }
  }
}
