import UIKit

protocol HomeViewControllerProtocol: AnyObject {
  func startLoading()
  func stopLoading()
}

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

    viewModel.setupDelegate(delegate: self)
  }
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
  func redirectToPlaces() {
    viewModel.redirectToPlaces()
  }

  func redirectToMap() {
    viewModel.redirectToMap()
  }
}

// MARK: - HomeViewControllerProtocol
extension HomeViewController: HomeViewControllerProtocol {
  func startLoading() {
    baseView.startLoading()
  }

  func stopLoading() {
    baseView.stopLoading()
  }
}
