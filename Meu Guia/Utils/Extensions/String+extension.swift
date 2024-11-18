import Foundation

extension String {
  static var empty: String {
    return ""
  }

  var onlyNumbers: String {
    return self.filter { ( $0.isNumber ) }
  }

  var isBlank: Bool {
    return self.removeWhiteSpaces().isEmpty
  }

  var isNotBlank: Bool {
    return !isBlank
  }

  var isNotEmpty: Bool {
    return !self.isEmpty
  }

  func containsIgnoringCase(find: String) -> Bool {
    return range(of: find, options: .caseInsensitive) != nil
  }

  func removeWhiteSpaces() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
