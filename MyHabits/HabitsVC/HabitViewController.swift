//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 09.06.2023.
//

import UIKit

final class HabitViewController: UIViewController {
    
    public var optHabit: Habit? = nil
    
//    MARK: HabbitTextField
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
        textField.text = "Бегать по утрам, спать 8 часов и т.п."
        textField.delegate = self
        textField.autocorrectionType = .no
//        textField.addTarget(self, action: #selector(textFieldAction), for: .editingDidEnd)
        return textField
    }()
    
//    MARK: ColorPicker
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()

    private lazy var colorButton: UIButton = {
        let button = UIButton()
        let colorPickerVC = UIColorPickerViewController()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemOrange
        button.addTarget(self, action: #selector(colorButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var colorPickerVC: UIColorPickerViewController = {
        let colorPickerViewController = UIColorPickerViewController()
        colorPickerViewController.delegate = self
        return colorPickerViewController
    }()
    
//    MARK: TimePicker
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
        textField.placeholder = "error"
        textField.textColor = .systemPurple
        textField.inputView = timePicker
        textField.text = timeFormat(time: timePicker.date)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(timePickerAction(timePicker:)), for: .valueChanged)
        return datePicker
    }()
    
//    MARK: DeleteButton
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        return button
    }()
    
    
//    MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupLayout()
        setupNavigationBar()
        view.addTapGestureToHideKeyboard()
        
        if let habit = optHabit {
            prepareVCToEdit(habit: habit)
        } else {
            habitTextField.becomeFirstResponder()
        }
    }
    
    
    @objc private func returnActrion() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveAction() {
        let store = HabitsStore.shared
        if let habit = optHabit {
            habit.name = habitTextField.text ?? ""
            habit.date = timePicker.date
            habit.color = colorButton.backgroundColor!
        } else {
            let newHabit = Habit(name: habitTextField.text ?? "",
                                 date: timePicker.date,
                                 color: colorButton.backgroundColor!)
            store.habits.append(newHabit)
        }
        returnActrion()
    }
 
    
//    MARK: Layout
    private func setupLayout() {
        [nameLabel, habitTextField, colorLabel, colorButton, timeLabel, timeSubLabel, timePickerField, timePicker, deleteButton].forEach {
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
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupNavigationBar() {
//        navigationController?.navigationBar.topItem?.title = "Создать"
        
        let leftBarButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(returnActrion))
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = rightBarButton
    }
   
//    MARK: Actions
    @objc private func textFieldAction() {
        
    }

    @objc private func colorButtonAction() {
        present(colorPickerVC, animated: true)
    }
    
    @objc private func timePickerAction(timePicker: UIDatePicker) {
        timePickerField.text = timeFormat(time: timePicker.date)
    }
    
    @objc private func deleteButtonAction() {
        if let habit = optHabit {
            let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(String(habit.name)) ?", preferredStyle: .alert)
            let cancelAlert = UIAlertAction(title: "Отмена", style: .cancel)
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
                HabitsStore.shared.habits.removeAll{
                    $0 == habit
                }
                self.returnActrion()
            }
            alert.addAction(cancelAlert)
            alert.addAction(deleteAction)
            present(alert, animated: true)
        }
    }
    
//    MARK: Others
    private func prepareVCToEdit(habit: Habit) {
        colorButton.backgroundColor = habit.color
        habitTextField.textColor = habit.color
        habitTextField.text = habit.name
        timePickerField.text = timeFormat(time: habit.date)
        timePicker.date = habit.date
        deleteButton.isHidden = false
    }
    
    private func timeFormat(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: time)
    }
}



extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = viewController.selectedColor
    }
}


extension UIView {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        addGestureRecognizer(tapGesture)
    }
}
