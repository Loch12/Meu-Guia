import UIKit
import MapKit

// MARK: - PlaceNavigationViewController
class PlaceNavigationViewController: BaseViewController<PlaceNavigationView> {
  // MARK: - Properties
  var navigation: NavigationGuide?
  let viewModel: PlaceNavigationViewModelProtocol

  // MARK: - Init
  init(viewModel: PlaceNavigationViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavBarBackButton()
    baseView.mapView.delegate = self
    startNavigation()
  }
  
  func startNavigation() {
    guard let coordinates = viewModel.getCoordinates() else {
      showAlert(message: "Houve um erro ao carregar as coordenadas do local. Tente novamente mais tarde.") {
        self.dismiss(animated: true)
      }
      return
    }
    NavigationGuide.shared.delegate = self
    NavigationGuide.shared.start(destination: coordinates)
  }
}

// MARK: - MapView Delegate
extension PlaceNavigationViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    
    if let polyline = overlay as? MKPolyline {
      let renderer = MKPolylineRenderer(polyline: polyline)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 6
      return renderer
    }
    
    if let circle = overlay as? MKCircle {
      let renderer = MKCircleRenderer(circle: circle)
      renderer.fillColor = UIColor.systemGreen.withAlphaComponent(0.3)
      renderer.strokeColor = .systemGreen
      renderer.lineWidth = 2
      return renderer
    }
    
    return MKOverlayRenderer(overlay: overlay)
  }
}

// MARK: - NavigationGuide
extension PlaceNavigationViewController: NavigationGuideDelegate {
  func didUpdateRoute(_ route: MKRoute) {
    baseView.mapView.removeOverlays(baseView.mapView.overlays)
    baseView.mapView.addOverlay(route.polyline)

    let rect = route.polyline.boundingMapRect
    baseView.mapView.setVisibleMapRect(rect,
                              edgePadding: UIEdgeInsets(top: 80, left: 40, bottom: 80, right: 40),
                              animated: true)
  }
  
  func didUpdateStepRegions(_ regions: [MKCircle]) {
    baseView.mapView.addOverlays(regions)
  }
}
