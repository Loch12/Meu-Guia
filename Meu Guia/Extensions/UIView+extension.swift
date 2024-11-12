import UIKit

extension UIView {
  func addSubviews(_ subviews: UIView...) {
    for subview in subviews {
      subview.translatesAutoresizingMaskIntoConstraints = false
      addSubview(subview)
    }
  }
}
