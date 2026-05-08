import CoreLocation
import MapKit

extension NavigationGuide {
  func bearing(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) -> CLLocationDirection {
    let lat1 = start.latitude * .pi / 180
    let lon1 = start.longitude * .pi / 180
    let lat2 = end.latitude * .pi / 180
    let lon2 = end.longitude * .pi / 180
    
    let dLon = lon2 - lon1
    
    let y = sin(dLon) * cos(lat2)
    let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
    
    let radians = atan2(y, x)
    let degrees = radians * 180 / .pi
    
    return (degrees + 360).truncatingRemainder(dividingBy: 360)
  }
  
  func cardinalDirection(for step: MKRoute.Step) -> Double? {
    let polyline = step.polyline
    guard polyline.pointCount >= 2 else { return nil }
    
    var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: polyline.pointCount)
    polyline.getCoordinates(&coords, range: NSRange(location: 0, length: polyline.pointCount))
    
    guard let start = coords.first,
          let end = coords.last else {
      return nil
    }
    
    return bearing(from: start, to: end)
  }
  
  func distanceToRoute(route: MKRoute?, from location: CLLocation) -> CLLocationDistance? {
    guard let polyline = route?.polyline else { return nil }
    
    let pointCount = polyline.pointCount
    let points = polyline.points()
    
    var minDistance = CLLocationDistance.greatestFiniteMagnitude
    
    for i in 0..<(pointCount - 1) {
      let start = points[i].coordinate
      let end = points[i + 1].coordinate
      
      let distance = distanceFromPoint(location.coordinate,
                                       to: start,
                                       segmentEnd: end)
      
      minDistance = min(minDistance, distance)
    }
    
    return minDistance
  }
  
  func distanceFromPoint(_ point: CLLocationCoordinate2D,
                                 to segmentStart: CLLocationCoordinate2D,
                                 segmentEnd: CLLocationCoordinate2D) -> CLLocationDistance {
    let p = MKMapPoint(point)
    let a = MKMapPoint(segmentStart)
    let b = MKMapPoint(segmentEnd)
    
    let ab = MKMapPoint(x: b.x - a.x, y: b.y - a.y)
    let ap = MKMapPoint(x: p.x - a.x, y: p.y - a.y)
    
    let abLengthSquared = ab.x * ab.x + ab.y * ab.y
    let dot = ap.x * ab.x + ap.y * ab.y
    guard abLengthSquared > 0 else { return p.distance(to: a) }
    let t = max(0, min(1, dot / abLengthSquared))
    
    let closest = MKMapPoint(x: a.x + ab.x * t,
                             y: a.y + ab.y * t)
    
    return p.distance(to: closest)
  }
}
