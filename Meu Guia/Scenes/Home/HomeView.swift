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
  private lazy var homeIcon: UIImageView = {
    let view = UIImageView()
    view.image = .icHome
    view.contentMode = .scaleAspectFill
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var homeDescription: UILabel = {
    let label = UILabel()
    label.text = .homeDescriptionText
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .primaryColor
    label.font = .nunito(.bold, size: 24)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var seeToursButton: UIButton = {
    let button = UIButton()
    button.setTitle(.searchToursButtonText, for: .normal)
    button.titleLabel?.font = .nunito(.bold, size: 20)
    button.layer.cornerRadius = 7
    button.backgroundColor = .buttonBaseColor
    button.addTarget(self, action: #selector(redirectToOnlineTours), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var savedToursButton: UIButton = {
    let button = UIButton()
    button.setTitle(.savedToursButtonText, for: .normal)
    button.titleLabel?.font = .nunito(.bold, size: 20)
    button.layer.cornerRadius = 7
    button.backgroundColor = .buttonBaseColor
    button.addTarget(self, action: #selector(redirectToSavedTours), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func setup() {
    addSubviews(homeIcon,
                homeDescription,
                seeToursButton,
                savedToursButton)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      homeIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
      homeIcon.widthAnchor.constraint(equalToConstant: 150),
      homeIcon.heightAnchor.constraint(equalToConstant: 150),
      homeIcon.centerXAnchor.constraint(equalTo: centerXAnchor),

      homeDescription.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: 48),
      homeDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      homeDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      homeDescription.bottomAnchor.constraint(equalTo: seeToursButton.topAnchor, constant: -10),

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
