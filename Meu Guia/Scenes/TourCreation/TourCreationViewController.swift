import UIKit

// MARK: - TourCreationViewController
class TourCreationViewController: BaseViewController<TourCreationView> {
  var onComplete: ((TourModel?) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavBarBackButton()
    baseView.delegate = self
  }
}

// MARK: - PlaceCreationViewDelegate
extension TourCreationViewController: TourCreationViewDelegate {
  func cancelCreation() {
    onComplete?(nil)
    dismiss(animated: true)
  }
  
  func confirmCreation() {
    guard baseView.checkValidation() else {
      showAlert(message: .requiredNameAlert)
      return
    }
    let tour = TourModel(name: baseView.getName(),
                         id: IdGenerator.nextId(),
                         places: [],
                         isEdited: true)
    onComplete?(tour)
    dismiss(animated: true)
  }
}
