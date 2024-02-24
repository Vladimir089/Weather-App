//
//  HumidityCollectionViewCell.swift
//  ToDoList
//
//  Created by Владимир Кацап on 24.02.2024.
//

import UIKit

class HumidityCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientBackground()
    }
    
    private func setupGradientBackground() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        let humidityTextLabel: UILabel = {
            let label = UILabel()
            label.text = "Влажность %"
            label.textColor = .systemGray
            label.font = .systemFont(ofSize: 20, weight: .light)
            return label
        }()
        addSubview(humidityTextLabel)
        humidityTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        
        let humidityLabel: UILabel = {
            let label = UILabel()
            label.text = "\(Int(weather?.main.humidity ?? 1))"
            label.textColor = .systemBlue
            label.font = .systemFont(ofSize: 100, weight: .ultraLight)
            return label
        }()
        addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
}
