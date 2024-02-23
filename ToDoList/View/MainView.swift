//
//  MainView.swift
//  ToDoList
//
//  Created by Владимир Кацап on 22.02.2024.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientBackground()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemGreen.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Анимация изменения цветов градиента
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = [UIColor.white.cgColor, UIColor.systemRed.cgColor]
        animation.duration = 20 // Продолжительность анимации в секундах
        animation.autoreverses = true // Автоматическое воспроизведение анимации в обратном порядке
        animation.repeatCount = Float.infinity // Бесконечное повторение анимации
        gradientLayer.add(animation, forKey: "gradientAnimation")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
    
    func createComponents() {
        let labelGeo: UILabel = {
            let label = UILabel()
            label.text = "Текущее место"
            label.font = .systemFont(ofSize: 30, weight: .medium)
            label.textColor = .white
            return label
        }()
        addSubview(labelGeo)
        labelGeo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70)
        }
        
        let labelCity: UILabel = {
            let label = UILabel()
            label.textColor = .white
            if let name = weather?.name {
                label.text = "\(name)"
            }
            label.font = .systemFont(ofSize: 15, weight: .medium)
            return label
        }()
        addSubview(labelCity)
        labelCity.snp.makeConstraints { make in
            make.bottom.equalTo(labelGeo).inset(-17)
            make.centerX.equalToSuperview()
        }
        
        let labeltemp: UILabel = {
            let label = UILabel()
            label.text = "\(String(weather?.main.temp ?? 1))°C"
            label.font = .systemFont(ofSize: 100, weight: .light)
            label.textColor = .white
            label.numberOfLines = 0
            return label
        }()
        addSubview(labeltemp)
        labeltemp.snp.makeConstraints { make in
            make.top.equalTo(labelCity).inset(30)
            make.centerX.equalToSuperview()
        }
        
        let middleView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 30
            return view
        }()
        addSubview(middleView)
        middleView.snp.makeConstraints { make in
            make.top.equalTo(labeltemp).inset(150)
            make.height.equalTo(400)
            make.width.equalTo(350)
            make.centerX.equalToSuperview()
        }
        
        middleView.layer.shadowColor = UIColor.black.cgColor
        middleView.layer.shadowOpacity = 0.5
        middleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        middleView.layer.shadowRadius = 4
        middleView.layer.masksToBounds = false
        
        if let weatherDescription = weather?.weather.first?.description {
            let labelDop: UILabel = {
                let label = UILabel()
                label.font = .systemFont(ofSize: 25, weight: .light)
                label.text = weatherDescription
                label.textColor = .white
                return label
            }()
            
            addSubview(labelDop)
            labelDop.snp.makeConstraints { make in
                make.bottom.equalTo(labeltemp).inset(-5)
                make.centerX.equalToSuperview()
            }
        }
        
       
        let viewMainMinMaxTemp: UIView = {
            let view = UIView()
            view.clipsToBounds  = true
            view.backgroundColor = .clear
            view.layer.cornerRadius = 2
            return view
        }()
        
        middleView.addSubview(viewMainMinMaxTemp)
        viewMainMinMaxTemp.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.top.equalToSuperview().inset(30)
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
            let colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor, UIColor.green.cgColor, UIColor.yellow.cgColor, UIColor.orange.cgColor, UIColor.red.cgColor]
            let locations: [NSNumber] = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
            gradientLayer.colors = colors
            gradientLayer.locations = locations

            // Создаем изображение из градиентного слоя
            UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0.0)
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            // Устанавливаем изображение как фон прогресс-вью
            view.trackImage = image

            // Устанавливаем прогресс в соответствии с текущей температурой
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
            label.text = "\(String(weather?.main.tempMin ?? 1))°C"
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.textColor = .systemBlue
            return label
        }()
        middleView.addSubview(minTepLabel)
        minTepLabel.snp.makeConstraints { make in
            make.top.equalTo(viewMainMinMaxTemp).inset(10)
            make.left.equalToSuperview().inset(30)
        }
        
        let maxTepLabel: UILabel = {
            let label = UILabel()
            label.text = "\(String(weather?.main.tempMax ?? 1))°C"
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.textColor = .systemBlue
            return label
        }()
        middleView.addSubview(maxTepLabel)
        maxTepLabel.snp.makeConstraints { make in
            make.top.equalTo(viewMainMinMaxTemp).inset(10)
            make.right.equalToSuperview().inset(30)
        }
        
    }
}
