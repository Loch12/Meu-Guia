import UIKit

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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    title = viewModel.place.name
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    baseView.delegate = self
  }

  func setupView() {
    setupNavBarBackButton()
    baseView.setupInfo(place: viewModel.place)
  }
}

extension PlaceDetailViewController: PlaceDetailViewDelegate {
  func showAlert(message: String?) {
    let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
