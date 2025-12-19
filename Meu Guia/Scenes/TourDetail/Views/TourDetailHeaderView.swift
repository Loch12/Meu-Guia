import UIKit

final class TourDetailHeaderView: UIView {

  // MARK: - Components
  private let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.layer.cornerRadius = 10
    view.backgroundColor = .gray.withAlphaComponent(0.1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let activity: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.hidesWhenStopped = true
    activity.color = .primaryColor
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  private let titleLabel: BaseLabel = {
    let label = BaseLabel()
    label.font = .nunito(.bold, textStyle: .largeTitle, size: 30)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let descriptionLabel: BaseLabel = {
    let label = BaseLabel()
    label.font = .nunito(.regular, textStyle: .body, size: 24)
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
    setupConstraints()
  }

  // MARK: - Setup
  private func setupView() {
    addSubview(contentView)

    contentView.addSubviews(imageView,
                            titleLabel,
                            descriptionLabel)

    imageView.addSubview(activity)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      imageView.heightAnchor.constraint(equalToConstant: 200),

      activity.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
      activity.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),

      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }

  // MARK: - Public API
  func configure(tour: TourModel) {
    titleLabel.text = tour.name
    descriptionLabel.text = tour.description

    loadImage(from: tour.image)
  }

  // MARK: - Image loading
  private func loadImage(from urlString: String?) {
    imageView.image = nil

    guard let urlString = urlString else {
      activity.stopAnimating()
      imageView.image = .detailPlaceholder
      return
    }

    activity.startAnimating()

    urlString.loadRemoteImage { [weak self] image in
      DispatchQueue.main.async {
        guard let self = self else { return }
        self.activity.stopAnimating()
        self.imageView.image = image ?? .detailPlaceholder
      }
    }
  }
}
