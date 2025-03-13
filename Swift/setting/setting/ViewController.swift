//
//  ViewController.swift
//  setting
//
//  Created by buildbook on 3/13/25.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = SettingsViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 32, height: 50)
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 40) // 섹션 헤더 크기
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: SettingsCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "설정"
        view.backgroundColor = .systemBackground
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsCollectionViewCell.identifier, for: indexPath) as! SettingsCollectionViewCell
        let item = viewModel.getItem(at: indexPath)
        
        cell.configure(with: item)
        cell.toggleAction = { [weak self] isOn in
            self?.viewModel.toggleItem(at: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getItem(at: indexPath)
        
        switch item.type {
        case .push:
            if let vcType = item.destinationVC {
                let destinationVC = vcType.init()
                navigationController?.pushViewController(destinationVC, animated: true)
            } else {
                print("푸시 대상 뷰컨트롤러가 설정되지 않았습니다.")
            }
        case .alert:
            let alert = UIAlertController(title: "알림", message: item.alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            present(alert, animated: true)
        case .toggle:
            break // 토글은 셀에서 처리
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            header.subviews.forEach { $0.removeFromSuperview() } // 재사용 시 기존 뷰 제거
            
            let label = UILabel()
            label.text = viewModel.getSectionTitle(at: indexPath.section)
            label.font = .boldSystemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            header.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
                label.centerYAnchor.constraint(equalTo: header.centerYAnchor)
            ])
            
            return header
        }
        return UICollectionReusableView()
    }
}
