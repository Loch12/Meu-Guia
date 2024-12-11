import UIKit

class PlaceTableViewCell: UITableViewCell {
  private let cardView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 7
    view.backgroundColor = .lightColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let title: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .primaryColor
    label.font = .nunito(.bold, size: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let icon: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 7
    image.translatesAutoresizingMaskIntoConstraints = false
    image.clipsToBounds = true
    image.image = .icHome
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
    backgroundColor = .clear
    contentView.addSubviews(cardView)
    cardView.addSubviews(icon, title)
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
      cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      cardView.bottomAnchor.constraint(equalTo: icon.bottomAnchor, constant: 16),

      icon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
      icon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      icon.heightAnchor.constraint(equalToConstant: 64),
      icon.widthAnchor.constraint(equalToConstant: 64),

      title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
      title.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
      title.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
      title.topAnchor.constraint(greaterThanOrEqualTo: icon.topAnchor),
      title.bottomAnchor.constraint(lessThanOrEqualTo: icon.bottomAnchor),

      contentView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 12)
    ])
  }

  func configure(text: String?, image: String?) {
    title.text = text
    image?.loadRemoteImage { image in
      DispatchQueue.main.async {
        self.icon.image = image ?? .icHome
      }
    }
  }
}
