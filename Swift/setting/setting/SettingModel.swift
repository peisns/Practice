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
    case button // 새로운 셀 타입
}

struct SettingsItem {
    let title: String
    let type: SettingsItemType
    var isEnabled: Bool? // toggle에만 사용
    let destinationVC: UIViewController.Type? // AnyClass? -> UIViewController.Type?로 변경
    let alertMessage: String? // alert에만 사용
    let action: (() -> Void)? // button에만 사용
}
struct SettingsSection {
    let title: String // 제목은 여전히 let으로 유지 가능
    var items: [SettingsItem] // items를 var로 변경
}
