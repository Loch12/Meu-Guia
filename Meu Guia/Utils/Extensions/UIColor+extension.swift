import UIKit

extension UIColor {
  static var primaryColor = UIColor(hex: GlobalConfiguration.primaryColor)
  static var buttonBaseColor = UIColor(hex: GlobalConfiguration.buttonBaseColor)
  static var lightColor = UIColor(hex: GlobalConfiguration.lightColor)
  static var warmGray = UIColor(hex: "979797")
}

extension UIColor {
  convenience init(hex: String) {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    if (cString.count) != 6 {
      self.init(
        red: 255,
        green: 255,
        blue: 255,
        alpha: 1
      )
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
