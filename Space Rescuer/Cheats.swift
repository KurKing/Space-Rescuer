//
//  Cheats.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import Foundation

class Cheats {
    static let shared = Cheats()
    
    var isCollisionCheatCodeActivated = false
    func enterCheatCode(code: String) -> (Bool, String) {
        if code.hash == 3720932424078554781 {
            isCollisionCheatCodeActivated = true
            return (true, "Сollision is disabled!")
        }
        return (false, "Unknown cheat code!")
    }
    
    private init() {}
}
