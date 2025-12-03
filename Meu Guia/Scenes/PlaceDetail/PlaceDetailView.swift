import UIKit

protocol PlaceDetailViewDelegate: AnyObject {
  func showAlert(message: String?)
}

// MARK: - PlaceDetail
class PlaceDetailView: BaseView {
  // MARK: - Properties
  var place: PlaceDetailModel?
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
                     placeSite,
                     placePhone,
                     placeHour)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var placeIcon: UIImageView = {
    let view = UIImageView()
    view.image = .icHome
    view.addSubview(activity)
    view.contentMode = .scaleAspectFit
    view.backgroundColor = .gray.withAlphaComponent(0.1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var activity: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView(style: .whiteLarge)
    activity.backgroundColor = .gray.withAlphaComponent(0.2)
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  private lazy var placeName: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .nunito(.bold, size: 28)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private lazy var placeDescription: TitleValueView = {
    let view = TitleValueView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var placeHour: TitleValueView = {
    let view = TitleValueView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var placeSite: TitleValueView = {
    let view = TitleValueView()
    view.setupColor(title: .black, value: .blue)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var placePhone: TitleValueView = {
    let view = TitleValueView()
    view.setupColor(title: .black, value: .blue)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  // MARK: - Override Methods
  override func setup() {
    addSubview(scrollView)
    setupActions()
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

      activity.topAnchor.constraint(equalTo: placeIcon.topAnchor),
      activity.leadingAnchor.constraint(equalTo: placeIcon.leadingAnchor),
      activity.trailingAnchor.constraint(equalTo: placeIcon.trailingAnchor),
      activity.bottomAnchor.constraint(equalTo: placeIcon.bottomAnchor),

      placeName.topAnchor.constraint(equalTo: placeIcon.bottomAnchor, constant: 24),
      placeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      placeDescription.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 12),
      placeDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      placeHour.topAnchor.constraint(equalTo: placeDescription.bottomAnchor, constant: 12),
      placeHour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeHour.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      placePhone.topAnchor.constraint(equalTo: placeHour.bottomAnchor, constant: 12),
      placePhone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placePhone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

      placeSite.topAnchor.constraint(equalTo: placePhone.bottomAnchor, constant: 12),
      placeSite.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      placeSite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      placeSite.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }

  func setupActions() {
    var tap = UITapGestureRecognizer(target: self, action: #selector(openSite))
    placeSite.addGestureRecognizer(tap)
    tap = UITapGestureRecognizer(target: self, action: #selector(callPhone))
    placePhone.addGestureRecognizer(tap)
    placeSite.isUserInteractionEnabled = true
    placePhone.isUserInteractionEnabled = true
  }

  func setupInfo(place: PlaceDetailModel) {
    self.place = place
    placeIcon.image = .icHome
    placeName.text = place.name
    placeDescription.setupInfo(title: "Descrição:", value: place.description)
    placePhone.setupInfo(title: "Telefone:", value: place.phone)
    placeSite.setupInfo(title: "Site:", value: place.site)
    placeHour.setupInfo(title: "Horário:", value: place.schedule)

    activity.startAnimating()
    place.image?.loadRemoteImage(completion: { image in
      DispatchQueue.main.async {
        self.activity.stopAnimating()
        if let image = image {
          self.placeIcon.image = image
        }
      }
    })
  }

  @objc func openSite() {
    guard let site = place?.site,
          let appURL = URL(string: site),
          UIApplication.shared.canOpenURL(appURL) else {
      delegate?.showAlert(message: .siteErrorMessage)
      return
    }
    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
  }

  @objc func callPhone() {
    guard let phone = place?.phone,
          let appURL = URL(string: "tel://" + phone),
          UIApplication.shared.canOpenURL(appURL) else {
      delegate?.showAlert(message: .phoneCallErrorMessage)
      return
    }
    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
  }
}
