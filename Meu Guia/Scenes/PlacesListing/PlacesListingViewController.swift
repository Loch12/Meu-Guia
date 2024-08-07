import UIKit

// MARK: - PlacesListingViewController
class PlacesListingViewController: BaseViewController<PlacesListingView> {
  // MARK: - Properties
  let viewModel: PlacesListingViewModelProtocol

  // MARK: - Init
  init(viewModel: PlacesListingViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
