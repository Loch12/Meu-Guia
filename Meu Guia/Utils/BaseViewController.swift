import UIKit

class BaseViewController<T: BaseView>: UIViewController {
  var baseView: T {
    if let view = view as? T {
      return view
    } else {
      let baseView = T()
      view = baseView
      return baseView
    }
  }

  override func loadView() {
    let baseView = T()
    view = baseView
  }
}
