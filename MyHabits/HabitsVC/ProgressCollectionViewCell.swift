//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Иван Захаров on 14.06.2023.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
//    MARK: Labels
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        label.text = "Всё получится!"
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
//    MARK: ProgressView
    private lazy var mainProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .systemGray
        progressView.tintColor = .systemPurple
        return progressView
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
    
//    MARK: Cell method
    public func setupCell(habits: [Habit]){
        if habits.isEmpty {
            percentLabel.text = "0%"
            mainProgressView.progress = 0
        } else {
            var takenCounter: Float = 0
            for habit in habits {
                if habit.isAlreadyTakenToday == true {
                    takenCounter += 1
                }
            }
            
            let toProgress: Float = takenCounter / Float(habits.count)
            percentLabel.text = "\(Int(toProgress * 100)) %"
            mainProgressView.progress = toProgress
        }
    }
    
//    MARK: Layout
    private func setupLayout() {
        [mainLabel, percentLabel, mainProgressView].forEach {
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            mainProgressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            mainProgressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainProgressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            mainProgressView.heightAnchor.constraint(equalToConstant: 7),
            
            percentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
