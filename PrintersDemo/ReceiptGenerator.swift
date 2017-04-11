//
//  ReceiptGenerator.swift
//  PrintersDemo
//
//  Created by Chonnawee Chatcherthaicharoen on 3/20/2560 BE.
//  Copyright © 2560 Chonnawee Chatcherthaicharoen. All rights reserved.
//

import Foundation

class ReceiptGenerator {
    var showShopLogo: Bool
    var suffix: String
    
//    var receipt: String {
//        var receiptBody: String = ""
//        let centerParagraph = NSMutableParagraphStyle()
//        centerParagraph.alignment = .center
//        
//    }
//    
    init(showShopLogo: Bool, suffix: String) {
        self.showShopLogo = showShopLogo
        self.suffix = suffix
    }
    
    private func imageFromAttributes(_ attributes: [NSAttributedString]) -> UIImage? {
        
        var receiptSize = CGSize(width: 576, height: 0)
        
        for attribute in attributes {
            let size = attribute.size()
            receiptSize.height += size.height
        }
        
        receiptSize.height += 10
        
        UIGraphicsBeginImageContext(receiptSize)
        
        let textRect = CGRect(x: 0, y: 0, width: receiptSize.width, height: receiptSize.height)
        
        let context = UIGraphicsGetCurrentContext()
        
        UIColor.white.set()
        
        context?.fill(textRect)
        
        var posY = 0
        for attribute in attributes {
            let size = attribute.size()
            attribute.draw(in: CGRect(x: 0, y: posY, width: Int(receiptSize.width), height: Int(receiptSize.height)))
            posY += Int(size.height)
        }
        
        guard let imageToPrint: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return imageToPrint
    }

}
