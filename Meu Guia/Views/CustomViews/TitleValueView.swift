import UIKit

class TitleValueView: UIView {
  // MARK: - Components
  let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .nunito(.bold, size: 20)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let valueLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .nunito(.regular, size: 16)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
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
    addSubviews(titleLabel,
                valueLabel)

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

      bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor)
    ])
  }

  func setupInfo(title: String?, value: String?) {
    titleLabel.text = title
    valueLabel.text = value
  }

  func setupFont(title: UIFont, value: UIFont) {
    titleLabel.font = title
    valueLabel.font = value
  }

  func setupColor(title: UIColor, value: UIColor) {
    titleLabel.textColor = title
    valueLabel.textColor = value
  }
}
