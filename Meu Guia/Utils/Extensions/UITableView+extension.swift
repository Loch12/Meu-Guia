import UIKit

extension UITableViewCell: ReusableViewProtocol {}

extension UITableView {
  func registerReusableCell<T: UITableViewCell>(_: T.Type) {
    register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to Dequeue Reusable Table View Cell")
    }
    cell.selectionStyle = .none
    return cell
  }
}

// MARK: - ReusableViewProtocol
protocol ReusableViewProtocol {
  static var reuseIdentifier: String { get }
}

extension ReusableViewProtocol {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
