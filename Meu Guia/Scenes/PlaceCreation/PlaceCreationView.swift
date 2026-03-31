import UIKit

protocol PlaceCreationViewDelegate: BaseViewControllerProtocol {
  func confirmCreation()
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
    view.addSubviews()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
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
      
      confirmButton.heightAnchor.constraint(equalToConstant: 48),
      confirmButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
      confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    ])
  }
  
  @objc func confirmAction() {
    delegate?.confirmCreation()
  }
}
