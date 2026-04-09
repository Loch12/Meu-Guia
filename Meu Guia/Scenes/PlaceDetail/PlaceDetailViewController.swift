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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel.fetchPlace()
    baseView.setupView(place: viewModel.getPlaceInfo(), isOnline: viewModel.isOnline)
  }
}

// MARK: - PlaceDetailViewDelegate
extension PlaceDetailViewController: PlaceDetailViewDelegate {
  func deletePlace() {
    showAlert(message: .deletePlaceWarning, cancelOption: true) {
      self.viewModel.deletePlace { result in
        let action = result ? { self.successfulDelete() } : { self.failedDelete() }
        action()
      }
    }
  }
  
  func successfulDelete() {
    showAlert(message: .successDeletePlace) {
      self.viewModel.returnToListing()
    }
  }
  
  func failedDelete() {
    showAlert(message: "Houve um erro ao tentar excluir o local. Tente novamente.")
  }
  
  func startNavigation() {
    viewModel.startNavigation()
  }
  
  func editPlace() {
    viewModel.editPlace()
  }
}
