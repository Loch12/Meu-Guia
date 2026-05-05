import Foundation
import MapKit
import CoreLocation
import AVFoundation

protocol NavigationGuideDelegate: AnyObject {
  func didUpdateRoute(_ route: MKRoute)
  func didUpdateStepRegions(_ regions: [MKCircle])
}

final class NavigationGuide: NSObject {
  // MARK: - Properties
  static let shared = NavigationGuide()
  weak var delegate: NavigationGuideDelegate?
  
  private let locationManager = CLLocationManager()
  private let synthesizer = AVSpeechSynthesizer()
  
  private var route: MKRoute?
  private var steps: [MKRoute.Step] = []
  private var destination: CLLocationCoordinate2D?
  private var hasToCalculateRoute: Bool = true
  private var currentStepIndex = 0
  private var hasSpokenCurrentStep = false
  private var stepRegions: [StepRegion] = []
  private var triggeredSteps: Set<Int> = []
  
  // MARK: - Init
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.pausesLocationUpdatesAutomatically = false
    locationManager.distanceFilter = 5
    locationManager.headingFilter = kCLHeadingFilterNone
    locationManager.startUpdatingHeading()
  }
  
  // MARK: - Public API
  func start(destination: CLLocationCoordinate2D) {
    self.destination = destination
    speak(text: "Iniciando trajeto")
    
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  func stop() {
    locationManager.stopUpdatingLocation()
    self.destination = nil
  }
  
  func isCurrentDestination(destination: CLLocationCoordinate2D?) -> Bool {
    self.destination?.latitude == destination?.latitude && self.destination?.longitude == destination?.longitude
  }
  
  func isNavigationActive() -> Bool {
    destination != nil
  }
  
  // MARK: - Route
  private func calculateRoute(from userLocation: CLLocation) {
    guard let destination = destination else { return }
    hasToCalculateRoute = false
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
      self.stepRegions = self.steps.enumerated().map { index, step in
        let circle = MKCircle(center: step.polyline.coordinate, radius: 20)
        return StepRegion(circle: circle, instruction: step.instructions)
      }
      self.delegate?.didUpdateRoute(route)
      self.delegate?.didUpdateStepRegions(self.stepRegions.map { $0.circle })
    }
  }
}

// MARK: - CLLocationManagerDelegate
extension NavigationGuide: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    
    guard let location = locations.last,
          let destination else { return }
    
    let distanceToDestination = location.distance(from: CLLocation(latitude: destination.latitude,
                                                                   longitude: destination.longitude))
    
    if distanceToDestination < 10 {
      didArrive()
      return
    }
    
    if hasToCalculateRoute {
      calculateRoute(from: location)
    }
    
    for (index, stepRegion) in stepRegions.enumerated() {
      if triggeredSteps.contains(index) { continue }
      
      let center = stepRegion.circle.coordinate
      let regionLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
      
      let distance = location.distance(from: regionLocation)
      
      if distance <= stepRegion.circle.radius {
        speak(text: stepRegion.instruction)
        triggeredSteps.insert(index)
      }
    }
  }
}

// MARK: - Voice
extension NavigationGuide {
  private func didArrive() {
    speak(text: "Você chegou ao destino")
    stop()
  }
  
  private func speak(text: String?) {
    guard let text else { return }
    
    let utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
    utterance.rate = 0.5
    
    synthesizer.speak(utterance)
  }
}

// MARK: - Instructions
extension NavigationGuide {
  private func simplifiedInstruction(for step: MKRoute.Step) -> String? {
    return "Siga por \(Int(step.distance)) metros, depois " + step.instructions.lowercased()
  }
}

struct StepRegion {
  let circle: MKCircle
  let instruction: String
}
