//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 09.06.2023.
//

import UIKit

final class HabitViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАЗВАНИЕ"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private lazy var habitTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        return textField
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()

    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemOrange
        return button
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВРЕМЯ"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private let timeSubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в "
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var timePickerField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "time"
        textField.textColor = .systemPurple
        return textField
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        
        return datePicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupLayout()
        setupNavigationBar()
    }
    
    
    private func setupLayout() {
        [nameLabel, habitTextField, colorLabel, colorButton, timeLabel, timeSubLabel, timePickerField, timePicker].forEach {
            view.addSubview($0)
        }
        
        view.backgroundColor = .white
        
        let topInset: CGFloat = 21
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topInset),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            habitTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            habitTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: topInset),
            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            colorButton.widthAnchor.constraint(equalTo: colorButton.heightAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: topInset),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            timeSubLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timeSubLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timePickerField.topAnchor.constraint(equalTo: timeSubLabel.topAnchor),
            timePickerField.leadingAnchor.constraint(equalTo: timeSubLabel.trailingAnchor),
            
            timePicker.topAnchor.constraint(equalTo: timeSubLabel.bottomAnchor, constant: 7),
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "Создать"
        let leftBarButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(returnActrion))
        navigationItem.leftBarButtonItem = leftBarButton
        
        
        let rightBarButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func returnActrion() {
        self.dismiss(animated: true)
    }
}
