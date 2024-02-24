//
//  MinMaxCell.swift
//  ToDoList
//
//  Created by Владимир Кацап on 24.02.2024.
//

import UIKit

class MinMaxCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createComp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createComp()
    }
    
    func createComp() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        backgroundColor = .white
        let viewMainMinMaxTemp: UIView = {
            let view = UIView()
            view.clipsToBounds  = true
            view.backgroundColor = .clear
            view.layer.cornerRadius = 2
            return view
        }()
        
        addSubview(viewMainMinMaxTemp)
        viewMainMinMaxTemp.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
        
        let progressViewMinMax: UIProgressView = {
            let view = UIProgressView()
            
            // Вычисляем прогресс текущей температуры в пределах от минимальной до максимальной
            guard let minTemperature = weather?.main.tempMin,
                  let maxTemperature = weather?.main.tempMax,
                  let currentTemperature = weather?.main.temp else {
                return view
            }
            let progress = (currentTemperature - minTemperature) / (maxTemperature - minTemperature)
            
            // Создаем градиент
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 4) // Установите желаемые размеры
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            
            // Создаем массив цветов для градиента с плавным переходом от синего к красному
            let colors = [UIColor.systemBlue.cgColor, UIColor.systemCyan.cgColor, UIColor.systemCyan.cgColor, UIColor.systemYellow.cgColor, UIColor.systemOrange.cgColor, UIColor.systemRed.cgColor]
            let locations: [NSNumber] = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
            gradientLayer.colors = colors
            gradientLayer.locations = locations
            UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            view.trackImage = image
            view.setProgress(Float(progress), animated: true)
            
            return view
        }()
        
        
        viewMainMinMaxTemp.addSubview(progressViewMinMax)
        progressViewMinMax.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(-1)
            
        }
        
        let minTepLabel: UILabel = {
            let label = UILabel()
            label.text = "\(String(Int(weather?.main.tempMin ?? 1)))°"
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.textColor = .systemBlue
            return label
        }()
        addSubview(minTepLabel)
        minTepLabel.snp.makeConstraints { make in
            make.top.equalTo(viewMainMinMaxTemp).inset(5)
            make.left.equalToSuperview().inset(30)
        }
        
        let maxTepLabel: UILabel = {
            let label = UILabel()
            label.text = "\(String(Int(weather?.main.tempMax ?? 1)))°"
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.textColor = .systemBlue
            return label
        }()
        addSubview(maxTepLabel)
        maxTepLabel.snp.makeConstraints { make in
            make.top.equalTo(viewMainMinMaxTemp).inset(5)
            make.right.equalToSuperview().inset(30)
        }
        
        let maxTempLabelTop: UILabel = {
            let label = UILabel()
            label.text = "макс"
            label.textColor = .systemBlue
            label.font = .systemFont(ofSize: 20, weight: .light)
            return label
        }()
        addSubview(maxTempLabelTop)
        maxTempLabelTop.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.bottom.equalTo(viewMainMinMaxTemp).inset(5)
        }
        
        let minTempLabelTop: UILabel = {
            let label = UILabel()
            label.text = "мин"
            label.textColor = .systemBlue
            label.font = .systemFont(ofSize: 20, weight: .light)
            return label
        }()
        addSubview(minTempLabelTop)
        minTempLabelTop.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.bottom.equalTo(viewMainMinMaxTemp).inset(5)
        }
        
        
        
    }
    
}
