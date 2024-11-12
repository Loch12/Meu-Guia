import UIKit

extension UIViewController {
  func setupNavBarBackButton(action: Selector? = nil) {
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
}
