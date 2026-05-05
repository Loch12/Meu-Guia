import UIKit
import MapKit

protocol PlaceNavigationViewDelegate: BaseViewControllerProtocol {}

// MARK: - PlaceEditView
class PlaceNavigationView: BaseView {
  // MARK: - Properties
  var place: PlaceModel?
  var delegate: PlaceNavigationViewDelegate?
  
  // MARK: - Components
  lazy var mapView: MKMapView = {
    let view = MKMapView()
    view.mapType = .mutedStandard
    view.showsCompass = false
    view.showsScale = false
    view.showsBuildings = false
    view.showsTraffic = false
    view.pointOfInterestFilter = .excludingAll
    view.showsUserLocation = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: - Override Methods
  override func setup() {
    addSubview(mapView)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
      mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
