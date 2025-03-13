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
        case .push, .alert, .button: // .button은 이 셀에서 사용되지 않음, 안전하게 처리
            toggleSwitch.isHidden = true
        }
    }
    
    @objc private func toggleChanged() {
        toggleAction?(toggleSwitch.isOn)
    }
}


class ButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "ButtonCollectionViewCell"
    
    private let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var tapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            button.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configure(with item: SettingsItem, action: @escaping () -> Void) {
        button.setTitle(item.title, for: .normal)
        tapAction = action
    }
    
    @objc private func buttonTapped() {
        tapAction?()
    }
}
