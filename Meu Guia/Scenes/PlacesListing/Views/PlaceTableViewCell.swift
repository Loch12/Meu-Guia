import UIKit

class PlaceTableViewCell: UITableViewCell {
  private let cardView: UIView = {
    let view = UIView()
    view.backgroundColor = .lightColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let title: UILabel = {
    let label = UILabel()
    return label
  }()

  private let icon: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    image.clipsToBounds = true
    return image
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
    contentView.addSubviews(cardView)
    cardView.addSubviews(icon, title)
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
      cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      cardView.bottomAnchor.constraint(equalTo: icon.bottomAnchor, constant: 16),

      icon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
      icon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      icon.heightAnchor.constraint(equalToConstant: 48),
      icon.widthAnchor.constraint(equalToConstant: 48),

      title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
      title.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
      title.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
    ])
  }
}
