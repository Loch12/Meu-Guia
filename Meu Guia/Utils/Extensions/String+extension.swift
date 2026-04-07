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
  
  func detectFieldType() -> InfoType {
    let content = self.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !content.isEmpty else {
      return .other
    }
    if isValidURL(content) {
      return .link
    }
    if isValidPhone(content) {
      return .phone
    }
    if content.count > 0 {
      return .text
    }
    
    return .other
  }
  
  private func isValidURL(_ string: String) -> Bool {
    let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    let range = NSRange(location: 0, length: string.utf16.count)
    
    let matches = detector?.matches(in: string, options: [], range: range)
    return matches?.first?.url != nil
  }
  
  private func isValidPhone(_ string: String) -> Bool {
    let numbers = string.filter { $0.isNumber }
    
    return numbers.count >= 10 && numbers.count <= 11
  }
}
