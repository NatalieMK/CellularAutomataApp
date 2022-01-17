//
//  SimpleCollectionViewCell.swift
//  CellularAutomata
//
//  Created by Natalie on 1/13/22.
//

import UIKit

class SimpleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SimpleCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
