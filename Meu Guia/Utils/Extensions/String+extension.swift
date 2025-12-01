import UIKit

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

  var localized: String {
    return NSLocalizedString(self, comment: "")
  }

  func containsIgnoringCase(find: String) -> Bool {
    return range(of: find, options: .caseInsensitive) != nil
  }

  func removeWhiteSpaces() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  func loadRemoteImage(completion: @escaping (UIImage?) -> Void) {
    guard let url = URL(string: self) else {
      completion(nil)
      return
    }
    DispatchQueue.global().async {
      do {
        let imageData = try Data(contentsOf: url)
        let image = UIImage(data: imageData)
        completion(image)
      } catch {
        completion(nil)
      }
    }
  }
}
