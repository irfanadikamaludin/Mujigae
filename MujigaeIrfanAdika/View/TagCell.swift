//
//  TagCell.swift
//  MujigaeIrfanAdika
//
//  Created by PACTINDO on 27/06/19.
//  Copyright © 2019 PACTINDO. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    
    @IBOutlet var tagName: UILabel!
    @IBOutlet weak var tagNameMaxWidthConstraint: NSLayoutConstraint!
    
    private var horizontalPadding: CGFloat = 32
    
    func setMaximumCellWidth(_ width: CGFloat) {
        self.tagNameMaxWidthConstraint.constant = width - horizontalPadding
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.tagName.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.tagName.numberOfLines = 0
        self.layer.cornerRadius = 20
        
    }
}



