import CoreLocation

class LocationPermissionManager: NSObject, CLLocationManagerDelegate {
  
  private let locationManager = CLLocationManager()
  private var completion: ((Bool) -> Void)?
  
  func requestPermission(completion: @escaping (Bool) -> Void) {
    self.completion = completion
    locationManager.delegate = self
    
    let status = locationManager.authorizationStatus
    
    switch status {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
      
    case .restricted, .denied:
      completion(false)
      
    case .authorizedWhenInUse, .authorizedAlways:
      completion(true)
      
    @unknown default:
      completion(false)
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      completion?(true)
      
    case .denied, .restricted:
      completion?(false)
      
    default:
      break
    }
  }
}
