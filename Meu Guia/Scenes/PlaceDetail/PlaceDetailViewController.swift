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

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavBarBackButton()
    baseView.delegate = self
    baseView.setupView(place: viewModel.getPlaceInfo(), isOnline: viewModel.isOnline)
  }
}

// MARK: - PlaceDetailViewDelegate
extension PlaceDetailViewController: PlaceDetailViewDelegate {
  func startNavigation() {
    viewModel.startNavigation()
  }
  
  func editPlace() {
    viewModel.editPlace()
  }
}
