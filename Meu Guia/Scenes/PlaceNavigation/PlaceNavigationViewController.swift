import UIKit

// MARK: - PlaceNavigationViewController
class PlaceNavigationViewController: BaseViewController<PlaceNavigationView> {
  // MARK: - Properties
  var navigation: NavigationGuide?
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
    startNavigation()
  }
  
  func startNavigation() {
    guard let coordinates = viewModel.getCoordinates() else {
      showAlert(message: "Houve um erro ao carregar as coordenadas do local. Tente novamente mais tarde.") {
        self.dismiss(animated: true)
      }
      return
    }
    NavigationGuide.shared.start(destination: coordinates)
  }
}

// MARK: - PlaceEditViewDelegate
extension PlaceNavigationViewController: PlaceNavigationViewDelegate {}
