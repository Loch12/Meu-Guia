import Foundation

protocol PlaceDetailWorkerProtocol {
  func fetchPlaceDetail(id: Int, completion: @escaping (Result<PlaceDetailModel, ErrorResponse>) -> Void)
}

class PlaceDetailWorker: PlaceDetailWorkerProtocol {
  func fetchPlaceDetail(id: Int, completion: @escaping (Result<PlaceDetailModel, ErrorResponse>) -> Void) {
    let result = true
    switch result {
    case true:
      if let mock = loadMockPlace() {
        completion(.success(mock))
        return
      }
      completion(.failure(ErrorResponse(error: .unexpected)))
    case false:
      completion(.failure(ErrorResponse(error: .unexpected)))
    }
  }

  func loadMockPlace() -> PlaceDetailModel? {
    guard let url = Bundle.main.url(forResource: "mockPlace", withExtension: "json") else {
      print("JSON file not found")
      return nil
    }

    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let places = try decoder.decode(PlaceDetailModel.self, from: data)
      return places
    } catch {
      print("Error decoding JSON: \(error)")
      return nil
    }
  }
}
