//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Иван Захаров on 20.06.2023.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
//    MARK: Models
    public var habit: Habit!
    private let habitStore = HabitsStore.shared
    private let dateModel = HabitsStore.shared.dates
    
//    MARK: UIElements
    private let tableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "АКТИВНОСТЬ"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var dateTableView: CustomTableView = {
        let tableView = CustomTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    
//  MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupNavigationBar()
        setupLayout()
    }
    
    
//    MARK: Layout
    private func setupLayout() {
        view.addSubview(tableLabel)
        view.addSubview(dateTableView)
        
        NSLayoutConstraint.activate([
            tableLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            tableLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            dateTableView.topAnchor.constraint(equalTo: tableLabel.bottomAnchor, constant: 7),
            dateTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = habit.name
        
        let editButton = UIBarButtonItem(title: "Править", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = editButton
    }
}



//MARK: DataSource extension
extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dateModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stringDate = HabitsStore.shared.trackDateString(forIndex: indexPath.row) else {
            fatalError("stringDate is empty")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.setupCell(dateString: stringDate, date: dateModel[indexPath.row], habit: habit)
        return cell
    }
}


//MARK: Delegate extension
extension HabitDetailsViewController: UITableViewDelegate {
    
}



//MARK: CustomCell class
final class CustomTableViewCell: UITableViewCell {
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEST"
        return label
    }()
    
    private let checkMark: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemPurple
        imageView.isHidden = true
        return imageView
    } ()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setupCell(dateString: String, date: Date, habit: Habit) {
        cellLabel.text = dateString
        
        if HabitsStore.shared.habit(habit, isTrackedIn: date) == true {
            checkMark.isHidden = false
        }
    }
    
    private func setupLayout() {
        addSubview(cellLabel)
        addSubview(checkMark)
        
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            checkMark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            checkMark.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 26),
            checkMark.widthAnchor.constraint(equalToConstant: 26)
        ])
    }
}



//MARK: CustomTableView class
final private class CustomTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
