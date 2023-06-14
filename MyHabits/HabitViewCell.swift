//
//  HabitViewCell.swift
//  MyHabits
//
//  Created by Иван Захаров on 14.06.2023.
//

import UIKit

final class HabitViewCell: UICollectionViewCell {
    
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
    
    private lazy var trackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        return button
//        checkmark.circle.fill
//        circle.fill
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [habitLabel, timeLabel, countLabel, trackButton].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .white
        
        let inset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            habitLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            habitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            timeLabel.topAnchor.constraint(equalTo: habitLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            
            trackButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            trackButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
