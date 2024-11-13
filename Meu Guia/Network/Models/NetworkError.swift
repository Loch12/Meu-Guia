import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
  case unexpected
  case notFound
  case forbidden
  case unauthorized
  case userNotFound

  var code: Int {
    switch self {
    case .unexpected:
      return 0
    case .unauthorized:
      return 401
    case .forbidden:
      return 403
    case .notFound:
      return 404
    case .userNotFound:
      return 0
    }
  }

  var localizedMessage: String {
    switch self {
    case .unexpected,
         .forbidden,
         .notFound:
      return "Algo inesperado aconteceu"
    case .userNotFound:
      return "Usuário não encontrado"
    case .unauthorized:
      return "Não autorizado"
    }
  }
}

// MARK: - Equatable
extension NetworkError: Equatable {}
