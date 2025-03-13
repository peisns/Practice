//
//  ProfileViewController.swift
//  setting
//
//  Created by buildbook on 3/13/25.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "프로필 편집"
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "프로필 편집 화면"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

class AccountSettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "계정 설정"
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "계정 설정 화면"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


class NotificationsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "알림 관리"
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "알림 관리 화면"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

class PrivacyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "개인정보"
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "개인정보 화면"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


class ThemeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "테마 설정"
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "테마 설정 화면"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

class HelpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "도움말"
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "도움말 화면"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
