import UIKit

// MARK: - PlaceEditViewController
class PlaceEditViewController: BaseViewController<PlaceCreationView> {
  // MARK: - Properties
  let viewModel: PlaceEditViewModelProtocol

  // MARK: - Init
  init(viewModel: PlaceEditViewModelProtocol) {
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
    baseView.setupStartValues(place: viewModel.getPlace())
  }
}

// MARK: - PlaceCreationViewDelegate
extension PlaceEditViewController: PlaceCreationViewDelegate {
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
    
    let place = PlaceModel(id: viewModel.getPlace().id,
                          name: baseView.getName(),
                          description: baseView.getDescription(),
                          info: baseView.getInfo(),
                          coordinates: viewModel.getPlace().coordinates)
    guard viewModel.save(place) else {
      showAlert(message: "Ocorreu um erro ao salvar, tente novamente")
      return
    }
    viewModel.returnView()
  }
}
