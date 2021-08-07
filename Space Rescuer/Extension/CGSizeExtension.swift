//
//  CGSizeExtension.swift
//  Space Rescuer
//
//  Created by Oleksiy on 07.08.2021.
//

import UIKit

extension CGSize {
    static func *(size: CGSize, multiplier: CGFloat) -> CGSize {
        CGSize(width: size.width * multiplier, height: size.height * multiplier)
    }
}
