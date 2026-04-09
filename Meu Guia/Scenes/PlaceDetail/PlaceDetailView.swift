import UIKit

protocol PlaceDetailViewDelegate: BaseViewControllerProtocol {
  func editPlace()
  func startNavigation()
  func deletePlace()
}

// MARK: - PlaceDetail
class PlaceDetailView: BaseView {
  // MARK: - Properties
  var place: PlaceModel?
  var delegate: PlaceDetailViewDelegate?

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
    view.addSubviews(placeName,
                     placeDescription,
                     infoStackView)
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

  private lazy var placeName: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.font = .nunito(.bold, textStyle: .largeTitle, size: 32)
    label.textColor = .black
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var placeDescription: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.font = .nunito(.regular, textStyle: .title1, size: 20)
    label.textColor = .black
    label.textAlignment = .justified
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var editButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .buttonBaseColor
    button.setTitle(.editAction, for: .normal)
    button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var deleteButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .invalidRed
    button.setTitle(.deleteAction, for: .normal)
    button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var navigationButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .buttonBaseColor
    button.setTitle(.navigationAction, for: .normal)
    button.addTarget(self, action: #selector(navigationAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var buttonStackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [editButton, navigationButton, deleteButton])
    view.spacing = 8
    view.axis = .vertical
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // MARK: - Override Methods
  override func setup() {
    addSubviews(scrollView, buttonStackView)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -5),

      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      placeName.topAnchor.constraint(equalTo: contentView.topAnchor),
      placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      placeDescription.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 12),
      placeDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      infoStackView.topAnchor.constraint(equalTo: placeDescription.bottomAnchor, constant: 16),
      infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      
      editButton.heightAnchor.constraint(equalToConstant: 48),
      navigationButton.heightAnchor.constraint(equalToConstant: 48),
      deleteButton.heightAnchor.constraint(equalToConstant: 48),
      
      buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
      buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
  }
  
  @objc func editAction() {
    delegate?.editPlace()
  }
  
  @objc func navigationAction() {
    delegate?.startNavigation()
  }
  
  @objc func deleteAction() {
    delegate?.deletePlace()
  }

  func setupView(place: PlaceModel, isOnline: Bool) {
    editButton.isHidden = isOnline
    deleteButton.isHidden = isOnline
    self.place = place
    placeName.text = place.name
    placeDescription.text = place.description
    setupInfo()
  }

  func setupInfo() {
    guard let infos = place?.info else { return }
    for info in infos {
      let infoView = TitleValueView()
      infoView.translatesAutoresizingMaskIntoConstraints = false
      infoView.setupInfo(info: info, delegate: delegate)
      infoStackView.addArrangedSubview(infoView)
    }
  }
}
