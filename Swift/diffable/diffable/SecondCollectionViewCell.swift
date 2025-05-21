//
//  SecondCollectionViewCell.swift
//  diffable
//
//  Created by air on 5/21/25.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .yellow
    }

}
