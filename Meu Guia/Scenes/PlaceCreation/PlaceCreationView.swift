import UIKit

protocol PlaceCreationViewDelegate: BaseViewControllerProtocol {
  func confirmCreation()
  func customFieldCreation()
}

// MARK: - PlaceCreationView
class PlaceCreationView: BaseView {
  // MARK: - Properties
  var place: PlaceModel?
  var delegate: PlaceCreationViewDelegate?
  
  // MARK: - Components
  private lazy var scrollView: UIScrollView = {
    let view = UIScrollView()
    view.addSubview(contentView)
    view.bounces = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var contentView: UIView = {
    let view = UIView()
    view.addSubviews(placeName, placeDescription, infoStackView, customFieldButton)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var placeName: EditTextView = {
    let view = EditTextView()
    view.configure(title: .placeNameCreation)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var placeDescription: EditTextView = {
    let view = EditTextView()
    view.configure(title: .placeDescriptionCreation)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var infoStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 12
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var customFieldButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .primaryColor
    button.setTitle(.addCustomFieldButton, for: .normal)
    button.addTarget(self, action: #selector(customFieldAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var confirmButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .buttonBaseColor
    button.setTitle(.saveAction, for: .normal)
    button.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  // MARK: - Override Methods
  override func setup() {
    addSubviews(scrollView, confirmButton)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -5),

      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      placeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
      placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      placeDescription.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 16),
      placeDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      infoStackView.topAnchor.constraint(equalTo: placeDescription.bottomAnchor, constant: 16),
      infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      customFieldButton.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
      customFieldButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
      customFieldButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64),
      customFieldButton.heightAnchor.constraint(equalToConstant: 48),
      customFieldButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      
      confirmButton.heightAnchor.constraint(equalToConstant: 48),
      confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
      confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
  }
  
  @objc func confirmAction() {
    delegate?.confirmCreation()
  }
  
  @objc func customFieldAction() {
    delegate?.customFieldCreation()
  }
  
  func checkValidation() -> Bool {
    placeName.hasValidText()
  }
  
  func createInfoView(info: PlaceDetailInfo?) {
    guard let info = info else { return }
    let infoView = TitleValueView()
    infoView.translatesAutoresizingMaskIntoConstraints = false
    infoView.setupInfo(info: info, delegate: delegate)
    infoStackView.addArrangedSubview(infoView)
  }
  
  func getName() -> String? {
    placeName.getValue()
  }
  
  func getDescription() -> String? {
    placeDescription.getValue()
  }
  
  func getInfo() -> [PlaceDetailInfo] {
    var infos: [PlaceDetailInfo] = []
    
    for view in infoStackView.arrangedSubviews {
      if let customView = view as? TitleValueView,
          let info = customView.info {
        infos.append(info)
      }
    }
    
    return infos
  }
  
  func setupStartValues(place: PlaceModel) {
    placeName.setupText(text: place.name)
    placeDescription.setupText(text: place.description)
    if let infos = place.info {
      for info in infos {
        createInfoView(info: info)
      }
    }
  }
}
