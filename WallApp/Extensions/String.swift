//
//  String.swift
//  WallApp
//
//  Created by 0xJs on 10/25/23.
//

import UIKit

extension String {
    func heightWidthConstraineWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constrainRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constrainRect,
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
}
