//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 20.06.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    public var habit: Habit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupLayout() {}
    
    private func setupNavigationBar() {}
}
