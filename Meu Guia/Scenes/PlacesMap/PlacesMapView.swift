import UIKit
import MapKit

// MARK: - PlacesMapViewDelegate
protocol PlacesMapViewDelegate: AnyObject {
  func openDetails()
}

// MARK: - PlacesMap
class PlacesMapView: BaseView {
  // MARK: - Properties
  var delegate: PlacesMapViewDelegate?

  // MARK: - Components
  private lazy var mapView: MKMapView = {
    let view = MKMapView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var detailButtonView: UIView = {
    let tap = UITapGestureRecognizer(target: self, action: #selector(openDetails))
    let view = UIView()
    view.isUserInteractionEnabled = true
    view.addGestureRecognizer(tap)
    view.isHidden = true
    view.backgroundColor = .white
    view.layer.cornerRadius = 16
    view.addSubview(detailButtonLabel)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var detailButtonLabel: UILabel = {
    let label = UILabel()
    label.text = "Ver detalhes"
    label.textColor = .primaryColor
    label.font = .nunito(.bold, size: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Override Method
  override func setup() {
    backgroundColor = .white
    addSubviews(mapView,
                detailButtonView)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
      mapView.bottomAnchor.constraint(equalTo: bottomAnchor),

      detailButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
      detailButtonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46),
      detailButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -46),
      detailButtonView.heightAnchor.constraint(equalToConstant: 48),

      detailButtonLabel.centerYAnchor.constraint(equalTo: detailButtonView.centerYAnchor),
      detailButtonLabel.centerXAnchor.constraint(equalTo: detailButtonView.centerXAnchor)
    ])
  }

  // MARK: - Methods
  func setupMap(delegate: MKMapViewDelegate, places: [PlaceModel]) {
    mapView.delegate = delegate
    setupAnnotations(places: places)
  }

  func setupAnnotations(places: [PlaceModel]) {
    var annotations = [MKPointAnnotation]()
    for place in places {
      if let annotationLocation = place.coordinates.getAddressLocation() {
        let annotation = MKPointAnnotation()
        annotation.title = place.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: annotationLocation.coordinate.latitude,
                                                       longitude: annotationLocation.coordinate.longitude)
        annotations.append(annotation)
      }
    }
    if places.count > 0 {
      mapView.addAnnotations(annotations)
      centerLocation(userLocation: places[0].coordinates)
    }
  }

  func centerLocation(userLocation: PlaceCoordinates?) {
    guard let userLocation = userLocation,
          let latitude = userLocation.latitude,
          let longitude = userLocation.longitude  else { return }

    mapView.centerToLocation(CLLocation(latitude: latitude, longitude: longitude),
                             regionRadius: 1000)
  }

  func toggleButton(isAvailable: Bool) {
    detailButtonView.isHidden = !isAvailable
  }

  @objc func openDetails() {
    delegate?.openDetails()
  }
}
