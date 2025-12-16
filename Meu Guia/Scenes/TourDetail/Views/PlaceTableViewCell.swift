import UIKit

class PlaceTableViewCell: UITableViewCell {
  private let cardView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 7
    view.backgroundColor = .lightColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let title: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.textColor = .primaryColor
    label.font = .nunito(.bold, textStyle: .title1, size: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let activity: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.hidesWhenStopped = true
    activity.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    activity.color = .primaryColor
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  private let icon: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 7
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

  // MARK: - Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    icon.image = nil
    activity.stopAnimating()
  }

  // MARK: - Methods
  private func setupComponents() {
    backgroundColor = .clear
    contentView.addSubviews(cardView)
    icon.addSubview(activity)
    cardView.addSubviews(icon, title)
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
      cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      cardView.bottomAnchor.constraint(greaterThanOrEqualTo: icon.bottomAnchor, constant: 16),
      cardView.bottomAnchor.constraint(greaterThanOrEqualTo: title.bottomAnchor, constant: 16),

      icon.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor, constant: 16),
      icon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
      icon.heightAnchor.constraint(equalToConstant: 64),
      icon.widthAnchor.constraint(equalToConstant: 64),

      activity.centerXAnchor.constraint(equalTo: icon.centerXAnchor),
      activity.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
      activity.widthAnchor.constraint(equalToConstant: 30),
      activity.heightAnchor.constraint(equalToConstant: 30),

      title.topAnchor.constraint(greaterThanOrEqualTo: cardView.topAnchor, constant: 16),
      title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
      title.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
      title.centerYAnchor.constraint(equalTo: icon.centerYAnchor),

      contentView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 12)
    ])
  }

  func configure(text: String?, image: String?) {
    title.text = text
    icon.image = nil
    activity.startAnimating()

    image?.loadRemoteImage { [weak self] image in
      DispatchQueue.main.async {
        guard let self = self else { return }
        self.activity.stopAnimating()
        self.icon.image = image ?? .placeholder
      }
    }
  }
}
