//
//  SecondHeaderCollectionReusableView.swift
//  diffable
//
//  Created by air on 5/21/25.
//

import UIKit

class SecondHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .orange
    }
    
}
