import UIKit

extension UIImage {
  static var icHome = UIImage(libImageNamed: "icHome")
  static var icArrowBack = UIImage(libImageNamed: "icArrowBack")
}

extension UIImage {
  convenience init?(libImageNamed imageName: String) {
    self.init(named: imageName, in: Bundle.main, compatibleWith: nil)
  }
}
