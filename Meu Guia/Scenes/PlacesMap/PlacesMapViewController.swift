import UIKit
import CoreLocation
import MapKit

// MARK: - PlacesMapViewController
class PlacesMapViewController: BaseViewController<PlacesMapView> {
  // MARK: - Properties
  let viewModel: PlacesMapViewModelProtocol
  let locationManager = CLLocationManager()
  var currentUserLocation: PlaceCoordinates?
  var selectedLocation: MKAnnotation?

  // MARK: - Init
  init(viewModel: PlacesMapViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Mapa"
    baseView.delegate = self
    setupNavBarBackButton()
    setupUserLocation()
    baseView.setupMap(delegate: self, places: viewModel.places)
  }

  func setupUserLocation() {
    self.locationManager.delegate = self
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
    self.locationManager.requestLocation()
  }
}

// MARK: - PlacesMapViewDelegate
extension PlacesMapViewController: PlacesMapViewDelegate {
  func openDetails() {
    guard let location = selectedLocation,
          let place = viewModel.places.first(where: { local in
            local.name == location.title
          }) else { return }
    viewModel.redirectToDetail(place: place)
  }
}

// MARK: - MKMapViewDelegate
extension PlacesMapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
    selectedLocation = annotation
    baseView.toggleButton(isAvailable: true)
  }

  func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
    selectedLocation = nil
    baseView.toggleButton(isAvailable: false)
  }
}

// MARK: - CLLocationManagerDelegate
extension PlacesMapViewController: CLLocationManagerDelegate {
  @available(iOS 14.0, *)
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager = CLLocationManager()) {
    switch manager.authorizationStatus {
    case .restricted, .denied, .notDetermined:
      manager.requestWhenInUseAuthorization()
    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    let authRetry: [CLAuthorizationStatus] = [.denied,
                                              .notDetermined,
                                              .restricted]
    if authRetry.contains(status) {
      locationManager.requestLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    currentUserLocation = PlaceCoordinates(latitude: locValue.latitude, longitude: locValue.longitude)
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    showAlert(error)
  }

  func showAlert(_ error: Error) {
    let alert = UIAlertController(title: .error,
                                  message: error.localizedDescription,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: .okMessage,
                                  style: .default))
    present(alert, animated: true)
  }
}
