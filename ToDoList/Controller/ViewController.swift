//
//  ViewController.swift
//  ToDoList
//
//  Created by Владимир Кацап on 20.02.2024.
//

import UIKit
import SnapKit
import Alamofire

var weather: Weather?

class ViewController: UIViewController {
    
    let locHelper = LoclizationHelper.shared
    var longitude, latitude: Double?
    var viewMain: MainView?

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locHelper.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: Notification.Name("LocationUpdated"), object: nil)
        viewMain = MainView()
        self.view = viewMain
    }
    
    @objc func locationUpdated() {
        locHelper.stopUpdatingLocation()
        NotificationCenter.default.removeObserver(self, name: Notification.Name("LocationUpdated"), object: nil)
        let coord = locHelper.getLonAndLan()
        self.longitude = coord[0]
        self.latitude = coord[1]
        Get()
    }
    
    func Get() {
        let parameters: Parameters = ["lat":latitude ?? 0.0, "lon": longitude ?? 0.0, "appid": "b8f2488c3e5b0e9acece16e869aa21f3", "units": "metric", "lang": "ru"]
        AF.request("https://api.openweathermap.org/data/2.5/weather", method: .get, parameters: parameters).response { response in
            if let data = response.data, let weat = try? JSONDecoder().decode(Weather.self, from: data) {
                weather = weat
                print(weat)
                DispatchQueue.main.async {
                    self.viewMain?.createComponents()
                }
            }
        }
    }
    
    
}
