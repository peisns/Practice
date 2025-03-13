//
//  SettingViewModel.swift
//  setting
//
//  Created by buildbook on 3/13/25.
//

import Foundation

class SettingsViewModel {
    var sections: [SettingsSection] = [
        SettingsSection(title: "", items: [
            SettingsItem(title: "빠른 설정 열기", type: .button, isEnabled: nil, destinationVC: nil, alertMessage: nil, action: {
                print("빠른 설정 버튼이 눌렸습니다!")
            }),
            SettingsItem(title: "캐시 지우기", type: .button, isEnabled: nil, destinationVC: nil, alertMessage: nil, action: {
                print("캐시 지우기 버튼이 눌렸습니다!")
            })
        ]),
        SettingsSection(title: "일반", items: [
            SettingsItem(title: "다크 모드", type: .toggle, isEnabled: false, destinationVC: nil, alertMessage: nil, action: nil),
            SettingsItem(title: "알림 설정", type: .toggle, isEnabled: true, destinationVC: nil, alertMessage: nil, action: nil),
            SettingsItem(title: "프로필 편집", type: .push, isEnabled: nil, destinationVC: ProfileViewController.self, alertMessage: nil, action: nil),
            SettingsItem(title: "계정 설정", type: .push, isEnabled: nil, destinationVC: AccountSettingsViewController.self, alertMessage: nil, action: nil),
            SettingsItem(title: "알림 관리", type: .push, isEnabled: nil, destinationVC: NotificationsViewController.self, alertMessage: nil, action: nil),
            SettingsItem(title: "개인정보", type: .push, isEnabled: nil, destinationVC: PrivacyViewController.self, alertMessage: nil, action: nil),
            SettingsItem(title: "테마 설정", type: .push, isEnabled: nil, destinationVC: ThemeViewController.self, alertMessage: nil, action: nil),
            SettingsItem(title: "도움말", type: .push, isEnabled: nil, destinationVC: HelpViewController.self, alertMessage: nil, action: nil)
        ]),
        SettingsSection(title: "계정", items: [
            SettingsItem(title: "로그아웃", type: .alert, isEnabled: nil, destinationVC: nil, alertMessage: "정말 로그아웃 하시겠습니까?", action: nil)
        ])
    ]
    
    func toggleItem(at indexPath: IndexPath) -> Bool? {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].items.count,
              sections[indexPath.section].items[indexPath.row].type == .toggle else { return nil }
        
        var item = sections[indexPath.section].items[indexPath.row]
        item.isEnabled?.toggle()
        sections[indexPath.section].items[indexPath.row] = item
        return item.isEnabled
    }
    
    func performButtonAction(at indexPath: IndexPath) {
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].items.count,
              sections[indexPath.section].items[indexPath.row].type == .button,
              let action = sections[indexPath.section].items[indexPath.row].action else { return }
        action()
    }
    
    func getItem(at indexPath: IndexPath) -> SettingsItem {
        return sections[indexPath.section].items[indexPath.row]
    }
    
    func getSectionTitle(at section: Int) -> String {
        return sections[section].title
    }
}
