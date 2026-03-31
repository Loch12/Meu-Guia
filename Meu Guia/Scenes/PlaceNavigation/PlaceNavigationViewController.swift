import UIKit

// MARK: - PlaceNavigationViewController
class PlaceNavigationViewController: BaseViewController<PlaceNavigationView> {
  // MARK: - Properties
  let viewModel: PlaceNavigationViewModelProtocol

  // MARK: - Init
  init(viewModel: PlaceNavigationViewModelProtocol) {
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
  }
}

// MARK: - PlaceEditViewDelegate
extension PlaceNavigationViewController: PlaceNavigationViewDelegate {}
