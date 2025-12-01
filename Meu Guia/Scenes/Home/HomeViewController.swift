import UIKit

// MARK: - HomeViewController
class HomeViewController: BaseViewController<HomeView> {
  // MARK: - Properties
  let viewModel: HomeViewModelProtocol

  // MARK: - Init
  init(viewModel: HomeViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
    baseView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = .homeTitle
    viewModel.setupDelegate(delegate: self)
  }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
  func redirectToOnlineTours() {
    viewModel.redirectToOnlineTours()
  }

  func redirectToSavedTours() {
    viewModel.redirectToSavedTours()
  }
}
