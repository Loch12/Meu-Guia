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
    NavigationGuide.shared.delegate = self
    baseView.delegate = self
    baseView.setupView(place: viewModel.getPlaceInfo(), isOnline: viewModel.isOnline)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel.fetchPlace()
    baseView.setupView(place: viewModel.getPlaceInfo(), isOnline: viewModel.isOnline)
    baseView.setupNavigationButton(isCurrentNavigation: NavigationGuide.shared.isCurrentDestination(destination: viewModel.getCoordinates()))
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
  
  func checkNavigation() {
    if NavigationGuide.shared.isCurrentDestination(destination: viewModel.getCoordinates()) {
      stopNavigation()
      return
    }
    let action = NavigationGuide.shared.isNavigationActive() ? { self.showAlertToNewNavigation() } : { self.startNavigation() }
    action()
  }
  
  func startNavigation() {
    guard let coordinates = viewModel.getCoordinates() else {
      showAlert(message: "Houve um erro ao tentar localizar o local. Tente novamente.")
      return
    }
    NavigationGuide.shared.start(destination: coordinates)
  }
  
  func stopNavigation() {
    NavigationGuide.shared.stop()
  }
  
  func showAlertToNewNavigation() {
    showAlert(message: "Já existe uma navegação em andamento, deseja continuar?", cancelOption: true) {
      self.startNavigation()
    }
  }
  
  func editPlace() {
    viewModel.editPlace()
  }
}

extension PlaceDetailViewController: NavigationGuideDelegate {
  func didStartedNavigation() {
    if NavigationGuide.shared.isCurrentDestination(destination: viewModel.getCoordinates()) {
      baseView.setupNavigationButton(isCurrentNavigation: true)
    }
  }
  
  func didFinishedNavigation() {
    baseView.setupNavigationButton(isCurrentNavigation: false)
  }
}
