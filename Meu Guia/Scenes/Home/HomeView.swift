import UIKit

// MARK: - HomeViewProtocol
protocol HomeViewProtocol: AnyObject {
  func redirectToPlaces()
  func redirectToMap()
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
    label.text = TargetUtils.getHomeDescription()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .primaryColor
    label.font = .nunito(.bold, size: 24)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var placesButton: UIButton = {
    let button = UIButton()
    button.setTitle("Acessar locais", for: .normal)
    button.titleLabel?.font = .nunito(.bold, size: 20)
    button.layer.cornerRadius = 7
    button.backgroundColor = .buttonBaseColor
    button.addTarget(self, action: #selector(redirectToPlaces), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var mapButton: UIButton = {
    let button = UIButton()
    button.setTitle("Acessar mapa", for: .normal)
    button.titleLabel?.font = .nunito(.bold, size: 20)
    button.layer.cornerRadius = 7
    button.backgroundColor = .buttonBaseColor
    button.addTarget(self, action: #selector(redirectToMap), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func setup() {
    backgroundColor = .white
    addSubviews(homeIcon,
                homeDescription,
                placesButton,
                mapButton)
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
      homeDescription.bottomAnchor.constraint(equalTo: placesButton.topAnchor, constant: -10),

      mapButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
      mapButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      mapButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      mapButton.heightAnchor.constraint(equalToConstant: 60),

      placesButton.bottomAnchor.constraint(equalTo: mapButton.topAnchor, constant: -24),
      placesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      placesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      placesButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }

  @objc func redirectToPlaces() {
    delegate?.redirectToPlaces()
  }

  @objc func redirectToMap() {
    delegate?.redirectToMap()
  }
}
