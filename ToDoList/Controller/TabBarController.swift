//
//  TabBarController.swift
//  ToDoList
//
//  Created by Владимир Кацап on 20.02.2024.
//

import UIKit

class TabBarController: UITabBarController {

    var arr = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = ViewController()
        let firstViewController2 = ViewController2()
        tabBar.backgroundColor = .systemGray4
        createTabBar(title: "первый", image: UIImage(named: "firstIcon") ?? nil, selectedImage: nil, viewController: firstViewController )
        createTabBar(title: "второй", image: UIImage(named: "firstIcon") ?? nil, selectedImage: nil, viewController: firstViewController2 )
    }
    
    func createTabBar(title: String, image: UIImage?, selectedImage: UIImage?, viewController: UIViewController) {

        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        
        viewController.tabBarItem = tabBarItem
        arr.append(viewController)
        self.setViewControllers(arr, animated: true)
    }
    
    
    
}
