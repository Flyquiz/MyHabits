//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 08.06.2023.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    private var habitModel = HabitsStore.shared.habits
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HabitViewCell.self, forCellWithReuseIdentifier: HabitViewCell.identifier)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        collectionView.backgroundColor = nil
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupAppearance()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(habitsCollectionView)
        
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitModel = HabitsStore.shared.habits
        habitsCollectionView.reloadData()
        print(habitModel)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonAction))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
        
        let debugDeleteButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(deleteAction))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = debugDeleteButton
    }
    
    @objc private func barButtonAction() {
        let habitNC = UINavigationController(rootViewController: HabitViewController())
        habitNC.modalPresentationStyle = .fullScreen
//        habitNC.navigationItem.backButtonDisplayMode = .default
        present(habitNC, animated: true)
    }
    @objc private func deleteAction() {
        HabitsStore.shared.habits = []
        habitsCollectionView.reloadData()
    }
}



extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return habitModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitViewCell.identifier, for: indexPath) as! HabitViewCell
            cell.setupCell(habit: habitModel[indexPath.item])
            return cell
        }
    }
    
    
}


extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width - 16 * 2
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 60)
        default:
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        default:
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
}


extension UIView {
    static var identifier: String {
        String(describing: self)
    }
}
