//
//  MainView.swift
//  ToDoList
//
//  Created by Владимир Кацап on 22.02.2024.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    var collectionView: UICollectionView?
    
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
            label.text = "\(String(Int(weather?.main.temp ?? 1)))"
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
                    make.bottom.equalTo(labeltemp).inset(-10)
                    make.centerX.equalToSuperview()
                }
            }
        
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collection.dataSource = self
            collection.delegate = self
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            collection.backgroundColor = .clear
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "1")
            collection.register(MinMaxCell.self, forCellWithReuseIdentifier: "2")
            collection.register(FellsCollectionViewCell.self, forCellWithReuseIdentifier: "3")
            collection.register(HumidityCollectionViewCell.self, forCellWithReuseIdentifier: "4")
            collection.register(PressureCollectionViewCell.self, forCellWithReuseIdentifier: "5")
            collection.register(UFIndexCollectionViewCell.self, forCellWithReuseIdentifier: "6")
            collection.register(WindCollectionViewCell.self, forCellWithReuseIdentifier: "7")
            return collection
        }()
        
        addSubview(collectionView!)
        collectionView!.snp.makeConstraints { make in
            make.top.equalTo(labeltemp).inset(130)
            make.left.right.bottom.equalToSuperview()
            
        }
    }
}


extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "2", for: indexPath) as! MinMaxCell
            cell.layer.cornerRadius = 20
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "3", for: indexPath) as! FellsCollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "4", for: indexPath) as! HumidityCollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "5", for: indexPath) as! PressureCollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "6", for: indexPath) as! UFIndexCollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "7", for: indexPath) as! WindCollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: frame.width - 20, height: 70)
        case 5:
            return CGSize(width: frame.width - 20, height: 140)
        default:
            return CGSize(width: 180, height: 180)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    
}
