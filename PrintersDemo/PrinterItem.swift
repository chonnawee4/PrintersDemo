//
//  PrinterItem.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/16/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import UIKit

class PrinterItem: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var address: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
