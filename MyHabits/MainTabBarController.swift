//
//  MainViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 08.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let habitNC = UINavigationController(rootViewController: HabitsViewController())
        let infoNC = UINavigationController(rootViewController: InfoViewController())
        habitNC.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "HabitsTabBarImage"), tag: 0)
        infoNC.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        UITabBar.appearance().backgroundColor = .systemGray5
        UITabBar.appearance().tintColor = .systemPurple
        UINavigationBar.appearance().tintColor = .systemPurple
        
        viewControllers = [habitNC, infoNC]
    }
}
