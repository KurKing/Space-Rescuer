//
//  Cheats.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import Foundation

class Cheats {
    static var isCheatCodeEntered = false
    static func enterCheatCode(code: String) {
        if code.hash == 3720932424078554781 {
            Cheats.isCheatCodeEntered = true
        }
    }
}
