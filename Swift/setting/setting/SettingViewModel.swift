//
//  SettingViewModel.swift
//  setting
//
//  Created by buildbook on 3/13/25.
//

import Foundation

class SettingsViewModel {
    var sections: [SettingsSection] = [
        SettingsSection(title: "일반", items: [
            SettingsItem(title: "다크 모드", type: .toggle, isEnabled: false, destinationVC: nil, alertMessage: nil),
            SettingsItem(title: "알림 설정", type: .toggle, isEnabled: true, destinationVC: nil, alertMessage: nil), // 추가된 토글
            SettingsItem(title: "프로필 편집", type: .push, isEnabled: nil, destinationVC: ProfileViewController.self, alertMessage: nil),
            SettingsItem(title: "계정 설정", type: .push, isEnabled: nil, destinationVC: AccountSettingsViewController.self, alertMessage: nil), // 추가된 뷰컨트롤러 1
            SettingsItem(title: "알림 관리", type: .push, isEnabled: nil, destinationVC: NotificationsViewController.self, alertMessage: nil), // 추가된 뷰컨트롤러 2
            SettingsItem(title: "개인정보", type: .push, isEnabled: nil, destinationVC: PrivacyViewController.self, alertMessage: nil), // 추가된 뷰컨트롤러 3
            SettingsItem(title: "테마 설정", type: .push, isEnabled: nil, destinationVC: ThemeViewController.self, alertMessage: nil), // 추가된 뷰컨트롤러 4
            SettingsItem(title: "도움말", type: .push, isEnabled: nil, destinationVC: HelpViewController.self, alertMessage: nil) // 추가된 뷰컨트롤러 5
        ]),
        SettingsSection(title: "계정", items: [
            SettingsItem(title: "로그아웃", type: .alert, isEnabled: nil, destinationVC: nil, alertMessage: "정말 로그아웃 하시겠습니까?")
        ])
    ]
    
    func toggleItem(at indexPath: IndexPath) -> Bool? {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].items.count,
              sections[indexPath.section].items[indexPath.row].type == .toggle else { return nil }
        sections[indexPath.section].items[indexPath.row].isEnabled?.toggle()
        return sections[indexPath.section].items[indexPath.row].isEnabled
    }
    
    func getItem(at indexPath: IndexPath) -> SettingsItem {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    func getSectionTitle(at section: Int) -> String {
        return sections[section].title
    }
}
