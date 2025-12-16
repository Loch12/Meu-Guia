import UIKit

extension UIFont {
  static func nunito(_ type: NunitoType, textStyle: UIFont.TextStyle, size: CGFloat) -> UIFont {
    guard let customFont = UIFont(name: "Nunito\(type.rawValue)", size: size) else {
      return UIFont.preferredFont(forTextStyle: textStyle)
    }

    return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
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
