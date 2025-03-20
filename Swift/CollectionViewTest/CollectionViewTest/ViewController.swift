//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by buildbook on 3/20/25.
//

import UIKit

class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "label1"
        return label
    }()
    let label2: UILabel = {
        let label = UILabel()
        label.text = "label2"
        return label
    }()
    let label3: UILabel = {
        let label = UILabel()
        label.text = "label3"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemGray6
        
        [label1, label2, label3].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            label1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            
            label2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 500),
            
            label3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 500),
            label3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                let vc = UIStoryboard(name: "Collection", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewController")
                let vcWithNavi = UINavigationController(rootViewController: vc)
                vcWithNavi.modalPresentationStyle = .fullScreen
                present(vcWithNavi, animated: false)
    }
}

