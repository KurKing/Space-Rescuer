//
//  MaxCountStorage.swift
//  Space Rescuer
//
//  Created by Oleksii on 01.03.2025.
//

import Foundation

class MaxCountStorage {
    
    private let userDefaults: UserDefaults = .standard
    
    var count: Int { maxCount }
    
    func set(count: Int) {
        
        if count > maxCount {
            maxCount = count
        }
    }
    
    private var maxCountKey: String {
        "space.rescuer.game.max.count"
    }
    private var maxCount: Int {
        get {
            userDefaults.integer(forKey: maxCountKey)
        }
        set {
            userDefaults.set(newValue, forKey: maxCountKey)
        }
    }
}
