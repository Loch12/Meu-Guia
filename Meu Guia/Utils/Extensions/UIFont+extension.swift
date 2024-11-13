import UIKit

extension UIFont {
  class func nunito(_ type: NunitoType, size: CGFloat = UIFont.systemFontSize) -> UIFont {
    return UIFont(name: "Nunito\(type.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
  }
}

extension UIFont {
  enum NunitoType: String, CaseIterable {
    case bold = "-Bold"
    case semiBold = "-SemiBold"
    case regular = "-Regular"
    case light = "-Light"
  }
}
