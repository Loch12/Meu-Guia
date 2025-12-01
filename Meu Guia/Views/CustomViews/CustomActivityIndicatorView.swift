import UIKit

class CustomActivityIndicatorView: UIView {
  private let activity: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView(style: .whiteLarge)
    activity.backgroundColor = .gray.withAlphaComponent(0.95)
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  private let warningText: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .nunito(.bold, size: 20)
    label.textColor = .white
    label.text = .loadingText
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupView() {
    addSubviews(activity, warningText)
    setupConstraints()
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      activity.topAnchor.constraint(equalTo: topAnchor),
      activity.leadingAnchor.constraint(equalTo: leadingAnchor),
      activity.trailingAnchor.constraint(equalTo: trailingAnchor),
      activity.bottomAnchor.constraint(equalTo: bottomAnchor),

      warningText.topAnchor.constraint(equalTo: activity.centerYAnchor, constant: 20),
      warningText.leadingAnchor.constraint(equalTo: activity.leadingAnchor, constant: 30),
      warningText.trailingAnchor.constraint(equalTo: activity.trailingAnchor, constant: -30)
    ])
  }

  func startAnimating() {
    activity.startAnimating()
  }

  func stopAnimating() {
    activity.stopAnimating()
  }
}
