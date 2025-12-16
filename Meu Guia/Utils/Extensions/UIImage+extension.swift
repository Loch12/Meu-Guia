import UIKit

extension UIImage {
  static var placeholder = UIImage(libImageNamed: "placeholder")
  static var detailPlaceholder = UIImage(libImageNamed: "detailPlaceholder")
  static var icArrowBack = UIImage(libImageNamed: "icArrowBack")
}

extension UIImage {
  convenience init?(libImageNamed imageName: String) {
    self.init(named: imageName, in: Bundle.main, compatibleWith: nil)
  }
}
