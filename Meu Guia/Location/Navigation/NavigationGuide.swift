import Foundation
import MapKit
import CoreLocation
import AVFoundation

protocol NavigationGuideDelegate: AnyObject {
  func didStartedNavigation()
  func didFinishedNavigation()
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
  private var isOffRoute = false
  private var hasError = false
  private var firstSearch = true
  
  private var stepRegions: [StepRegion] = []
  private var userHeading: Double = 0
  private var currentStep: Int?
  
  // MARK: - Init
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.pausesLocationUpdatesAutomatically = false
    locationManager.distanceFilter = 5
    locationManager.headingFilter = 1
  }
  
  // MARK: - Public API
  func start(destination: CLLocationCoordinate2D) {
    self.destination = destination
    delegate?.didStartedNavigation()
    speak(text: "Iniciando trajeto")
    speak(text: "Se quiser encerrar a navegação, deslize 3 dedos para baixo em qualquer tela do app")
    
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingHeading()
    locationManager.startUpdatingLocation()
  }
  
  func stop() {
    guard destination != nil else { return }
    delegate?.didFinishedNavigation()
    speak(text: "Encerrando navegação")
    locationManager.stopUpdatingLocation()
    locationManager.stopUpdatingHeading()
    self.destination = nil
    hasToCalculateRoute = true
    isOffRoute = false
    hasError = false
    firstSearch = true
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
            let route = response?.routes.first else {
        if !(self?.hasError ?? true) {
          self?.speak(text: "Houve um erro ao carregar a rota, aguarde.")
        }
        self?.hasError = true
        self?.hasToCalculateRoute = true
        return
      }
      
      self.speak(text: "Rota definida.")
      
      self.route = route
      self.steps = route.steps.filter { !$0.instructions.isEmpty }
      self.stepRegions = self.steps.enumerated().map { index, step in
        return StepRegion(circle: MKCircle(center: step.polyline.coordinate, radius: 10),
                          step: step,
                          direction: self.cardinalDirection(for: step))
      }
      if self.firstSearch,
         !self.stepRegions.isEmpty {
        speak(text: simplifiedInstruction(for: 0))
      }
      self.firstSearch = false
    }
  }
}

// MARK: - CLLocationManagerDelegate
extension NavigationGuide: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    userHeading = newHeading.trueHeading
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    
    if let distance = distanceToRoute(route: route, from: location) {
      if distance > 10 {
        if !isOffRoute,
           !firstSearch {
          isOffRoute = true
          speak(text: "Você saiu do trajeto")
          hasToCalculateRoute = true
          currentStep = nil
        }
      } else {
        isOffRoute = false
      }
    }
    
    for (index, stepRegion) in stepRegions.enumerated() {
      let center = stepRegion.circle.coordinate
      let regionLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
      let distance = location.distance(from: regionLocation)
      
      if distance <= stepRegion.circle.radius,
         currentStep != index {
        speak(text: simplifiedInstruction(for: index))
        currentStep = index
      }
    }
    
    if hasToCalculateRoute {
      calculateRoute(from: location)
    }
  }
}

// MARK: - Voice
extension NavigationGuide {
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
  private func simplifiedInstruction(for index: Int) -> String? {
    guard stepRegions.indices.contains(index) else {
      return nil
    }
    
    let currentStep = stepRegions[index]
    
    if currentStep.step.instructions.contains("destino") {
      stop()
      return currentStep.step.instructions
    }
    
    guard stepRegions.indices.contains(index + 1) else {
      return stepRegions[index].step.instructions
    }
    
    let nextDistance = Int(stepRegions[index + 1].step.distance)
    
    guard let directionText = readableDirection(for: stepRegions[index + 1]) else {
      return "siga por \(nextDistance) metros"
    }
    
    return "\(directionText) e siga por \(nextDistance) metros"
  }
  
  private func readableDirection(for step: StepRegion) -> String? {
    guard let stepDirection = step.direction else {
      return nil
    }
    
    let angle = (stepDirection - userHeading + 360).truncatingRemainder(dividingBy: 360)
    
    switch angle {
    case 0..<20, 340...360:
      return "Siga em frente"
    case 20..<60:
      return "Siga levemente à direita"
    case 60..<120:
      return "Vire à direita"
    case 120..<160:
      return "Vire forte à direita"
    case 160..<200:
      return "Retorne"
    case 200..<240:
      return "Vire forte à esquerda"
    case 240..<300:
      return "Vire à esquerda"
    case 300..<340:
      return "Siga levemente à esquerda"
    default:
      return nil
    }
  }
}
