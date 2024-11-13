import Foundation

// MARK: - ErrorResponse
public struct ErrorResponse: Codable, Error {
  let message: String
  let errors: [ErrorDetail]?
  let code: String?

  init(error: NetworkError) {
    self.message = error.localizedMessage
    self.errors = []
    self.code = nil
  }

  func allErrorValues() -> String {
    return errors?.compactMap { $0.values }.flatMap { $0 }.joined(separator: "\n") ?? ""
  }
}

struct ErrorDetail: Codable {
  let field: String?
  let values: [String]?
}
