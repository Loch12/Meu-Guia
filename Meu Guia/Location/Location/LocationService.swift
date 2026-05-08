import CoreLocation

final class LocationService: NSObject {
  
  static let shared = LocationService()
  
  private let locationManager = CLLocationManager()
  
  private(set) var lastLocation: CLLocation?
  
  private override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  // MARK: - Start
  
  func start() {
    let status = locationManager.authorizationStatus
    
    switch status {
    case .notDetermined:
      locationManager.requestAlwaysAuthorization()
      
    case .authorizedAlways:
      locationManager.startUpdatingLocation()
      
    case .denied, .restricted, .authorizedWhenInUse:
      break
      
    @unknown default:
      break
    }
  }
  
  func stop() {
    locationManager.stopUpdatingLocation()
  }
}

extension LocationService: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    
    if status == .authorizedWhenInUse || status == .authorizedAlways {
      manager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    
    lastLocation = location
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
  }
}
