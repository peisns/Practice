//
//  SettingCollectionViewCell.swift
//  setting
//
//  Created by buildbook on 3/13/25.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    static let identifier = "SettingsCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.isHidden = true
        return toggle
    }()
    
    var toggleAction: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toggleSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        toggleSwitch.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
    }
    
    func configure(with item: SettingsItem) {
        titleLabel.text = item.title
        
        switch item.type {
        case .toggle:
            toggleSwitch.isHidden = false
            toggleSwitch.isOn = item.isEnabled ?? false
        case .push, .alert:
            toggleSwitch.isHidden = true
        }
    }
    
    @objc private func toggleChanged() {
        toggleAction?(toggleSwitch.isOn)
    }
}
