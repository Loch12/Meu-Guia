import UIKit

// MARK: - HomeViewProtocol
protocol HomeViewProtocol: AnyObject {
  func redirectToOnlineTours()
  func redirectToSavedTours()
}

// MARK: - HomeView
class HomeView: BaseView {
  // MARK: - Properties
  var delegate: HomeViewProtocol?

  // MARK: - Components
  private lazy var homeDescription: BaseLabel = {
    let label = BaseLabel()
    label.text = .homeDescriptionText
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .primaryColor
    label.font = .nunito(.bold, textStyle: .largeTitle, size: 24)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var seeToursButton: UIButton = {
    let button = UIButton()
    button.setTitle(.searchToursButtonText, for: .normal)
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 20)
    button.layer.cornerRadius = 7
    button.backgroundColor = .buttonBaseColor
    button.addTarget(self, action: #selector(redirectToOnlineTours), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var savedToursButton: UIButton = {
    let button = UIButton()
    button.setTitle(.savedToursButtonText, for: .normal)
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 20)
    button.layer.cornerRadius = 7
    button.backgroundColor = .buttonBaseColor
    button.addTarget(self, action: #selector(redirectToSavedTours), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func setup() {
    addSubviews(homeDescription,
                seeToursButton,
                savedToursButton)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      homeDescription.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
      homeDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      homeDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

      savedToursButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
      savedToursButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      savedToursButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      savedToursButton.heightAnchor.constraint(equalToConstant: 60),

      seeToursButton.bottomAnchor.constraint(equalTo: savedToursButton.topAnchor, constant: -24),
      seeToursButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      seeToursButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      seeToursButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }

  @objc func redirectToOnlineTours() {
    delegate?.redirectToOnlineTours()
  }

  @objc func redirectToSavedTours() {
    delegate?.redirectToSavedTours()
  }
}
