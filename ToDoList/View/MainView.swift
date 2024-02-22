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
            label.text = "\(Int(weather?.main.temp ?? 1))"
            label.font = .systemFont(ofSize: 140, weight: .light)
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
            make.top.equalTo(labeltemp).inset(200)
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
        
       
        
        
        
        
        
    }
}
