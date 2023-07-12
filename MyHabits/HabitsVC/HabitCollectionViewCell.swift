//
//  HabitViewCell.swift
//  MyHabits
//
//  Created by Иван Захаров on 14.06.2023.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    
//    MARK: Models
    private var currentHabit: Habit!
    private var callBack: (() -> ())!
    private let dateModel = HabitsStore.shared.dates
    
//    MARK: Labels
    private let habitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "TEST"
        label.textColor = .blue
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.text = "TIMETEST"
        label.textColor = .systemGray2
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.text = "LABELTEST"
        label.textColor = .systemGray
        return label
    }()

//    MARK: TrackButton
    private lazy var trackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Cell methods
    public func setupCell(habit: Habit, callBack: @escaping () -> ()) {
        currentHabit = habit
        self.callBack = callBack
        
        habitLabel.textColor = habit.color
        trackButton.tintColor = habit.color
        habitLabel.text = habit.name
        timeLabel.text = habit.dateString
        countLabel.text = "Счетчик: \(getTrackCount(habit: habit))"
                
        if habit.isAlreadyTakenToday == true {
            trackButton.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38)), for: .normal)
        } else {
            trackButton.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38)), for: .normal)
            trackButton.addTarget(self, action: #selector(trackButtonAction), for: .touchUpInside)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        habitLabel.textColor = nil
        trackButton.tintColor = nil
        habitLabel.text = nil
        timeLabel.text = nil
    }
    
//    MARK: Layout
    private func setupLayout() {
        [habitLabel, timeLabel, countLabel, trackButton].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .systemGray6
        
        contentView.layer.cornerRadius = 8
        
        let inset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            habitLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            habitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            timeLabel.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            trackButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            trackButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            trackButton.heightAnchor.constraint(equalToConstant: 38),
//            trackButton.widthAnchor.constraint(equalTo: trackButton.heightAnchor)
        ])
    }
    
    private func getTrackCount(habit: Habit) -> Int {
        var count = 0
        for date in dateModel {
            if HabitsStore.shared.habit(habit, isTrackedIn: date) {
                count += 1
            }
        }
        return count
    }
    
//    MARK: Actions
    @objc private func trackButtonAction() {
        trackButton.setImage(UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38)), for: .normal)
        HabitsStore.shared.track(currentHabit)
        callBack()
    }
}
