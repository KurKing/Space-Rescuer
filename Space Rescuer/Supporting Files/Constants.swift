//
//  Constants.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import UIKit

extension String {
    static let backgroungImageName = "bg"
    static let spaceShip = "spaceShip"
    static let redSpaceShip = "redSpaceShip"
    static let blueSpaceShip = "blueSpaceShip"
    static let meteor = "meteor"
    static let astronaut = "astronaut"
    
    static let meteorFallingAction = "meteorFallingAction"
    
    static let customFontName = "GeoramaRoman-ExtraCondensedThin_Bold"
    
    static let playButton = "play-button"
    static let pauseButton = "pause-button"
    static let questionButton = "question-button"
    static let xButton = "x-button"
    
    static let title = "Space Rescuer"
}

extension UInt32 {
    static let meteor: UInt32 = 0x1 << 0
    static let spaceShip: UInt32 = 0x1 << 1
    static let astronaut: UInt32 = 0x1 << 2
}

extension CGFloat {
    static let menuViewCornerRadius: CGFloat = 20
}

extension UIColor {
    static let menuBackgroundColor = UIColor(named: "MenuBG-color")!
}
