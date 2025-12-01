import UIKit

protocol BaseViewControllerProtocol: AnyObject {
  func startLoading()
  func stopLoading()
}

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

extension BaseViewController: BaseViewControllerProtocol {
  func startLoading() {
    baseView.startLoading()
  }

  func stopLoading() {
    baseView.stopLoading()
  }
}
