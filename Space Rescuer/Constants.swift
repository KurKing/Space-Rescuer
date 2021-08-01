//
//  Constants.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import Foundation

extension String {
    static var backgroungImageName = "bg"
    static var spaceShip = "redSpaceShip"
    static let meteor = "meteor"
}

extension UInt32 {
    static let meteor: UInt32 = 0x1 << 0
    static let spaceShip: UInt32 = 0x1 << 1
}
