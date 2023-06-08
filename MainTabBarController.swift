//
//  MainViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 08.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let habbitNC = UINavigationController(rootViewController: HabitsViewController())
        let infoNC = UINavigationController(rootViewController: InfoViewController())
        habbitNC.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "HabbitsTabBarImage"), tag: 0)
        infoNC.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        UITabBar.appearance().backgroundColor = .systemGray5
        UITabBar.appearance().tintColor = .systemPurple
        viewControllers = [habbitNC, infoNC]
    }
}
