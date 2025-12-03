import UIKit

// MARK: - PlaceDetailViewControllerProtocol
protocol PlaceDetailViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
  func reloadInfo()
}

// MARK: - PlaceDetailViewController
class PlaceDetailViewController: BaseViewController<PlaceDetailView> {
  // MARK: - Properties
  let viewModel: PlaceDetailViewModelProtocol

  // MARK: - Init
  init(viewModel: PlaceDetailViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavBarBackButton()
    baseView.delegate = self
    viewModel.setControllerDelegate(self)
    viewModel.fetchPlaceDetail()
  }
}

// MARK: - PlaceDetailViewControllerProtocol
extension PlaceDetailViewController: PlaceDetailViewControllerProtocol {
  func reloadInfo() {
    guard let place = viewModel.place else { return }

    title = place.name
    baseView.setupInfo(place: place)
  }
}

// MARK: - PlaceDetailViewDelegate
extension PlaceDetailViewController: PlaceDetailViewDelegate {
  func showAlert(message: String?) {
    let alert = UIAlertController(title: .alert, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: .okMessage, style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
