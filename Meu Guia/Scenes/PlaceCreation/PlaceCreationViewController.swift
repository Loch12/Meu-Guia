import UIKit

// MARK: - PlaceCreationViewController
class PlaceCreationViewController: BaseViewController<PlaceCreationView> {
  // MARK: - Properties
  let viewModel: PlaceCreationViewModelProtocol

  // MARK: - Init
  init(viewModel: PlaceCreationViewModelProtocol) {
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    checkLocationPermission()
  }
  
  func checkLocationPermission() {
    LocationPermissionManager().requestPermission { [weak self] granted in
      guard let self = self else { return }
      
      DispatchQueue.main.async {
        guard granted else {
          self.showLocationAlert()
          return
        }
      }
    }
  }
  
  func showLocationAlert() {
    let alert = UIAlertController(
      title: "Permissão de localização",
      message: "Precisamos da sua localização para continuar.",
      preferredStyle: .alert
    )
    
    alert.addAction(UIAlertAction(title: .cancelAction, style: .cancel) { [weak self] _ in
      self?.viewModel.returnToMenu()
    })
    alert.addAction(UIAlertAction(title: "Abrir ajustes", style: .default) { _ in
      if let url = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(url)
      }
    })
    
    present(alert, animated: true)
  }
}

// MARK: - PlaceCreationViewDelegate
extension PlaceCreationViewController: PlaceCreationViewDelegate {
  func customFieldCreation() {
    viewModel.presentCustomFieldCreation { info in
      self.baseView.createInfoView(info: info)
    }
  }
  
  func confirmCreation() {
    guard baseView.checkValidation() else {
      showAlert(message: "O campo de nome é obrigatório")
      return
    }
    
    showAlert(message: "Escolha um tour para salvar o local") {
      self.viewModel.savePlace(place: PlaceModel(id: UUID(),
                                                 name: self.baseView.getName(),
                                                 description: self.baseView.getDescription(),
                                                 info: self.baseView.getInfo(),
                                                 coordinates: self.generateCoordinates()))
    }
  }
  
  func generateCoordinates() -> PlaceCoordinates? {
    guard let location = LocationService.shared.lastLocation else {
      return nil
    }
    
    return PlaceCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
  }
}
