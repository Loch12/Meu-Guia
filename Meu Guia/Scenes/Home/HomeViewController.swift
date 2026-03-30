import UIKit

// MARK: - HomeViewController
final class HomeViewController: BaseViewController<HomeView> {
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
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
  func redirectToSaveLocation() {
    viewModel.redirectToSaveLocation()
  }
  
  func redirectToOnlineTours() {
    viewModel.redirectToOnlineTours()
  }

  func redirectToSavedTours() {
    viewModel.redirectToSavedTours()
  }
}
