import Foundation
import MapKit
import CoreLocation

protocol NavigationGuideDelegate: AnyObject {
  func didUpdateInstruction(_ instruction: String)
  func didArrive()
}

class NavigationGuide: NSObject {
  // MARK: - Properties
  private let locationManager = CLLocationManager()
  private var route: MKRoute?
  private var steps: [MKRoute.Step] = []
  private var currentStepIndex = 0
  
  private let destination: CLLocationCoordinate2D
  
  weak var delegate: NavigationGuideDelegate?
  
  private let stepThreshold: Double = 15 // metros pra considerar que chegou no step
  
  // MARK: - Init
  init(destination: CLLocationCoordinate2D) {
    self.destination = destination
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func start() {
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  func stop() {
    locationManager.stopUpdatingLocation()
  }
  
  private func calculateRoute(from userLocation: CLLocation) {
    
    let request = MKDirections.Request()
    
    request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
    request.transportType = .walking
    
    let directions = MKDirections(request: request)
    
    directions.calculate { [weak self] response, error in
      guard let self = self,
            let route = response?.routes.first else { return }
      
      self.route = route
      self.steps = route.steps.filter { !$0.instructions.isEmpty }
      self.currentStepIndex = 0
      
      if let first = self.steps.first {
        self.delegate?.didUpdateInstruction(first.instructions)
      }
    }
  }
}

extension NavigationGuide: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    
    guard let location = locations.last else { return }
    
    // ainda não tem rota → cria
    if route == nil {
      calculateRoute(from: location)
      return
    }
    
    guard currentStepIndex < steps.count else {
      delegate?.didArrive()
      stop()
      return
    }
    
    let currentStep = steps[currentStepIndex]
    let stepLocation = currentStep.polyline.coordinate
    
    let stepCLLocation = CLLocation(latitude: stepLocation.latitude,
                                    longitude: stepLocation.longitude)
    
    let distance = location.distance(from: stepCLLocation)
    
    // chegou no step → avança
    if distance < stepThreshold {
      currentStepIndex += 1
      
      if currentStepIndex < steps.count {
        let nextInstruction = steps[currentStepIndex].instructions
        delegate?.didUpdateInstruction(nextInstruction)
      } else {
        delegate?.didArrive()
        stop()
      }
    }
  }
}
