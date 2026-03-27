import UIKit

protocol BaseViewControllerProtocol: AnyObject {
  func startLoading()
  func stopLoading()
  func showHelp()
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
    setupHelpButton()
  }

  // MARK: - Help
  func setupHelpButton() {
    let helpButton = UIBarButtonItem(
      title: "Ajuda",
      style: .plain,
      target: self,
      action: #selector(helpButtonTapped)
    )

    navigationItem.rightBarButtonItem = helpButton
  }

  @objc func helpButtonTapped() {
    showHelp()
  }

  func showHelp() {
    let alert = UIAlertController(
      title: nil,
      message: "Nenhuma ajuda disponível para esta tela.",
      preferredStyle: .alert
    )

    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
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
