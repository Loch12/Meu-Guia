import UIKit

extension UIViewController {
  func setupNavBarBackButton(action: Selector? = nil) {
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.backIndicatorImage = .icArrowBack
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = .icArrowBack
    navigationController?.navigationBar.tintColor = .warmGray

    if let action = action {
      let leftButton = UIBarButtonItem(image: .icArrowBack?.withRenderingMode(.alwaysOriginal),
                                       style: .plain,
                                       target: self,
                                       action: action)
      navigationItem.leftBarButtonItem = leftButton
    }
  }

  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAction))
    view.addGestureRecognizer(tap)
  }

  @objc func dismissKeyboardAction() {
    view.endEditing(true)
  }
}
