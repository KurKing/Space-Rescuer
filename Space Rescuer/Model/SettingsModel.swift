//
//  SettingsModel.swift
//  Space Rescuer
//
//  Created by Oleksiy on 02.08.2021.
//

import UIKit

struct SettingsModel {
    var meteorColor: MeteorColor
    var spaceShip: SpaceShipSpecifications
    var isCheatCodeEntered: Bool
    
    static var defaultSettings: SettingsModel {
        SettingsModel(meteorColor: .none, spaceShip: .red, isCheatCodeEntered: false)
    }
}

enum MeteorColor {
    case none
    case red
    case yellow
    case green
    case random
    
    var uiColor: UIColor {
        switch self {
        case .none:
            return .clear
        case .red:
            return .red
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .random:
            return [UIColor.red, UIColor.yellow,
                    UIColor.green, UIColor.clear].randomElement()!
        }
    }
}

enum SpaceShipSpecifications {
    case red
    case blue
    
    var speedDivider: Int {
        return self == .red ? 800 : 1000
    }
    
    var textureName: String {
        return self == .red ? .redSpaceShip: .blueSpaceShip
    }
}
