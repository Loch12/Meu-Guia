import UIKit

protocol PlaceDetailViewDelegate: AnyObject {
  func showAlert(message: String?)
}

// MARK: - PlaceDetail
class PlaceDetailView: BaseView {
  // MARK: - Properties
  var place: PlaceModel?
  var delegate: PlaceDetailViewDelegate?

  // MARK: - Components
  private lazy var scrollView: UIScrollView = {
    let view = UIScrollView()
    view.addSubview(contentView)
    view.bounces = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var contentView: UIView = {
    let view = UIView()
    view.addSubviews(placeIcon,
                     placeName,
                     placeDescription,
                     infoStackView)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var infoStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 12
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var placeIcon: UIImageView = {
    let view = UIImageView()
    view.addSubview(activity)
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.backgroundColor = .gray.withAlphaComponent(0.1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var activity: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.hidesWhenStopped = true
    activity.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    activity.color = .primaryColor
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  private lazy var placeName: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.font = .nunito(.bold, textStyle: .largeTitle, size: 32)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var placeDescription: TitleValueView = {
    let view = TitleValueView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // MARK: - Override Methods
  override func setup() {
    addSubview(scrollView)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      placeIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
      placeIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
      placeIcon.trailingAnchor.constraint(equalTo: trailingAnchor),
      placeIcon.heightAnchor.constraint(equalToConstant: 200),

      activity.centerXAnchor.constraint(equalTo: placeIcon.centerXAnchor),
      activity.centerYAnchor.constraint(equalTo: placeIcon.centerYAnchor),
      activity.widthAnchor.constraint(equalToConstant: 30),
      activity.heightAnchor.constraint(equalToConstant: 30),

      placeName.topAnchor.constraint(equalTo: placeIcon.bottomAnchor, constant: 24),
      placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      placeDescription.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 12),
      placeDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      infoStackView.topAnchor.constraint(equalTo: placeDescription.bottomAnchor, constant: 12),
      infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }

  func setupView(place: PlaceModel) {
    self.place = place
    placeName.text = place.name
    placeDescription.setupInfo(info: PlaceDetailInfo(title: .description,
                                                     value: place.description,
                                                     description: "",
                                                     type: .text),
                               delegate: delegate)
    setupInfo()
    loadImage()
  }

  func setupInfo() {
    guard let infos = place?.info else { return }
    for info in infos {
      let infoView = TitleValueView()
      infoView.translatesAutoresizingMaskIntoConstraints = false
      infoView.setupInfo(info: info, delegate: delegate)
      infoStackView.addArrangedSubview(infoView)
    }
  }

  func loadImage() {
    activity.startAnimating()
    place?.image?.loadRemoteImage(completion: { image in
      DispatchQueue.main.async {
        self.activity.stopAnimating()
        self.placeIcon.image = image ?? .detailPlaceholder
      }
    })
  }
}
