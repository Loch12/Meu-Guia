import UIKit

class CustomActivityIndicatorView: UIView {
  private let activity: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.hidesWhenStopped = true
    activity.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    activity.color = .white
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  private let warningText: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .nunito(.bold, textStyle: .title1, size: 20)
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
    backgroundColor = .gray.withAlphaComponent(0.95)
    addSubviews(activity, warningText)
    setupConstraints()
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      activity.centerXAnchor.constraint(equalTo: centerXAnchor),
      activity.centerYAnchor.constraint(equalTo: centerYAnchor),
      activity.heightAnchor.constraint(equalToConstant: 30),
      activity.widthAnchor.constraint(equalToConstant: 30),

      warningText.topAnchor.constraint(equalTo: activity.bottomAnchor, constant: 20),
      warningText.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }

  func startAnimating() {
    activity.startAnimating()
  }

  func stopAnimating() {
    activity.stopAnimating()
  }
}
