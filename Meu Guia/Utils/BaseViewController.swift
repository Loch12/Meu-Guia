import UIKit

protocol AlertMessageProtocol: AnyObject {
  func showAlert(message: String?, cancelOption: Bool, onConfirm: (() -> Void)?)
}

protocol BaseViewControllerProtocol: AlertMessageProtocol {
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

  // MARK: - Override Methods
  override func loadView() {
    let baseView = T()
    view = baseView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideKeyboardWhenTappedAround()
    setupGesture()
  }
  
  func setupGesture() {
    let gesture = UISwipeGestureRecognizer(target: self,
      action: #selector(handleGesture)
    )
    
    gesture.direction = .down
    gesture.numberOfTouchesRequired = 3
    gesture.cancelsTouchesInView = false
    view.addGestureRecognizer(gesture)
  }
  
  @objc func handleGesture() {
    NavigationGuide.shared.stop()
  }
}

extension BaseViewController: BaseViewControllerProtocol {
  func startLoading() {
    baseView.startLoading()
  }

  func stopLoading() {
    baseView.stopLoading()
  }
  
  func showAlert(message: String?, cancelOption: Bool = false, onConfirm: (() -> Void)? = nil) {
    let alert = UIAlertController(title: nil,
                                  message: message,
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Confirmar", style: .default) { _ in onConfirm?() })
    if cancelOption {
      alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
    }
    
    present(alert, animated: true)
  }
}
