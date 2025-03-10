//
//  ProgressButton.swift
//  ProgressButton
//
//  Created by buildbook on 3/10/25.
//

import UIKit

class ProgressButton: UIButton {
    let progressBar: UIProgressView =  {
        let progressBar = UIProgressView()
        progressBar.isUserInteractionEnabled = false
        return progressBar
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConfigure()
    }
    
    private func setConfigure() {
        self.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            progressBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            progressBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            progressBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
