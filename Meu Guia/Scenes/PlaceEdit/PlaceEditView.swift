import UIKit

protocol PlaceEditViewDelegate: BaseViewControllerProtocol {
  func confirmEdition()
}

// MARK: - PlaceEditView
class PlaceEditView: BaseView {
  // MARK: - Properties
  var place: PlaceModel?
  var delegate: PlaceEditViewDelegate?
  
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
  
  private lazy var confirmButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .buttonBaseColor
    button.setTitle(.saveAction, for: .normal)
    button.addTarget(self, action: #selector(confirmEdition), for: .touchUpInside)
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
      
      confirmButton.heightAnchor.constraint(equalToConstant: 48),
      confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
      confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
  }
  
  @objc func confirmEdition() {
    delegate?.confirmEdition()
  }
}
