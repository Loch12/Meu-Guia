import UIKit

class TitleValueView: UIView {
  // MARK: - Properties
  var info: PlaceDetailInfo?
  var delegate: AlertMessageProtocol?

  // MARK: - Components
  let titleLabel: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.font = .nunito(.bold, textStyle: .title1, size: 22)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let valueLabel: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.font = .nunito(.regular, textStyle: .callout, size: 16)
    label.textColor = .black
    label.isUserInteractionEnabled = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let deleteButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .invalidRed
    button.setTitle(.deleteAction, for: .normal)
    button.isHidden = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let buttonStackView: UIStackView = {
    let view = UIStackView()
    view.alignment = .leading
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupView() {
    deleteButton.addTarget(self, action: #selector(removeInfo), for: .touchUpInside)
    addSubviews(titleLabel,
                valueLabel,
                buttonStackView)
    buttonStackView.addArrangedSubview(deleteButton)
    setupConstraints()
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

      valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      buttonStackView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
      buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      buttonStackView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16),
      
      deleteButton.heightAnchor.constraint(equalToConstant: 36),

      bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor)
    ])
  }

  func setupInfo(info: PlaceDetailInfo, delegate: AlertMessageProtocol?) {
    self.info = info
    self.delegate = delegate
    titleLabel.text = "\(info.title ?? "Informação"):"
    valueLabel.text = info.value
    setupAction(type: info.type)
  }

  func setupAction(type: InfoType?) {
    guard let type = type else { return }
    let actions: [InfoType: UITapGestureRecognizer] = [
      .link: UITapGestureRecognizer(target: self, action: #selector(openSite)),
      .phone: UITapGestureRecognizer(target: self, action: #selector(callPhone))
    ]

    if let action = actions[type] {
      setupColor(title: .black, value: .blue)
      valueLabel.addGestureRecognizer(action)
    }
  }

  @objc func openSite() {
    guard let site = info?.value,
          let appURL = URL(string: site),
          UIApplication.shared.canOpenURL(appURL) else {
      delegate?.showAlert(message: .siteErrorMessage, cancelOption: false) {}
      return
    }
    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
  }

  @objc func callPhone() {
    guard let phone = info?.value,
          let appURL = URL(string: "tel://" + phone),
          UIApplication.shared.canOpenURL(appURL) else {
      delegate?.showAlert(message: .phoneCallErrorMessage, cancelOption: false) {}
      return
    }
    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
  }

  func setupColor(title: UIColor, value: UIColor) {
    titleLabel.textColor = title
    valueLabel.textColor = value
  }
  
  func setupDeleteOption() {
    deleteButton.isHidden = false
  }
  
  @objc func removeInfo() {
    if let stackView = superview as? UIStackView {
      stackView.removeArrangedSubview(self)
    }
    
    removeFromSuperview()
  }
}
