import Foundation
import CoreLocation

public class LoclizationHelper: NSObject {
    public static let shared = LoclizationHelper()
    private var currentLocation: CLLocationCoordinate2D?
    
    private var locationManager: CLLocationManager
    
    private override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
    }
    
    public func startUpdatingLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    public func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    
    
    public func getLonAndLan() -> [Double] {
        return [currentLocation?.longitude ?? 0.0, currentLocation?.latitude ?? 0.0]
    }
}

extension LoclizationHelper: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        NotificationCenter.default.post(name: Notification.Name("LocationUpdated"), object: nil)
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
