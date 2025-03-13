//
//  SettingModel.swift
//  setting
//
//  Created by buildbook on 3/13/25.
//

import UIKit

enum SettingsItemType {
    case toggle
    case push
    case alert
}

struct SettingsItem {
    let title: String
    let type: SettingsItemType
    var isEnabled: Bool? // 토글 상태 (toggle 타입에만 사용)
    let destinationVC: UIViewController.Type? // 푸시할 VC (push 타입에만 사용)
    let alertMessage: String? // 알림 메시지 (alert 타입에만 사용)
}

struct SettingsSection {
    let title: String
    var items: [SettingsItem]
}
