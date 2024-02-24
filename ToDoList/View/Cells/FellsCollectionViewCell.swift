//
//  FellsCollectionViewCell.swift
//  ToDoList
//
//  Created by Владимир Кацап on 24.02.2024.
//

import UIKit

class FellsCollectionViewCell: UICollectionViewCell {
    
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
        
        let feelsTextLabel: UILabel = {
            let label = UILabel()
            label.text = "Ощущается как"
            label.textColor = .systemGray
            label.font = .systemFont(ofSize: 20, weight: .light)
            return label
        }()
        addSubview(feelsTextLabel)
        feelsTextLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        
        let feelsLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 100, weight: .ultraLight)
            label.textColor = .systemBlue
            label.text = "\(String(Int(weather?.main.feelsLike ?? 1)))°"
            return label
        }()
        addSubview(feelsLabel)
        feelsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
    }
}
