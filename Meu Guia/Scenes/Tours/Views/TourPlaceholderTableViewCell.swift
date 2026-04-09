import UIKit

class TourPlaceholderTableViewCell: UITableViewCell {
  private let cardView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 7
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.borderWidth = 1
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let title: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.textColor = .primaryColor
    label.textAlignment = .center
    label.font = .nunito(.bold, textStyle: .title1, size: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Inits
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupComponents()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    setupComponents()
  }

  // MARK: - Methods
  private func setupComponents() {
    selectionStyle = .none
    backgroundColor = .clear
    contentView.addSubviews(cardView)
    cardView.addSubviews(title)
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
      cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      cardView.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),

      title.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor, constant: 40),
      title.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      title.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

      contentView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 12)
    ])
  }

  func configure(placeholder: String?) {
    title.text = placeholder
  }
}
