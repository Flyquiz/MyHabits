//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Иван Захаров on 14.06.2023.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
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
        label.text = "50%"
        return label
    }()
    
    private lazy var mainProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.5
        progressView.trackTintColor = .systemGray
        progressView.tintColor = .systemPurple
        return progressView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setupCell(habits: [Habit]) {
        
    }
    
    private func setupLayout() {
        [mainLabel, percentLabel, mainProgressView].forEach {
            contentView.addSubview($0)
        }
        
        contentView.backgroundColor = .white
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
