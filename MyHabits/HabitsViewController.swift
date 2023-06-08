//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 08.06.2023.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .systemGray6
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
    }
}
