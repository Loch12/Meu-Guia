import UIKit

// MARK: - CustomFieldCreationViewController
class CustomFieldCreationViewController: BaseViewController<CustomFieldCreationView> {
  var onComplete: ((PlaceDetailInfo?) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavBarBackButton()
    baseView.delegate = self
  }
}

// MARK: - PlaceCreationViewDelegate
extension CustomFieldCreationViewController: CustomFieldCreationViewDelegate {
  func cancelCreation() {
    onComplete?(nil)
    dismiss(animated: true)
  }
  
  func confirmCreation() {
    guard baseView.checkValidation() else {
      showAlert(message: .fieldsRequiredAlert)
      return
    }
    let info = PlaceDetailInfo(title: baseView.getTitle(),
                               value: baseView.getContent(),
                               description: nil,
                               type: baseView.getContent()?.detectFieldType())
    onComplete?(info)
    dismiss(animated: true)
  }
}
