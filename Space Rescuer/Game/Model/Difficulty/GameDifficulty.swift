//
//  GameDifficulty.swift
//  Space Rescuer
//
//  Created by Oleksii on 01.03.2025.
//

import Foundation
import RxSwift
import RxRelay

class GameDifficulty {
    
    let difficultyLevel: BehaviorRelay<Difficulty> = .init(value: .default)
    
    private var currentLevel = 0
    private let levels: [Difficulty] = [.default, .middle, .max]
    
    func increase() {
        
        currentLevel += 1
        
        if currentLevel >= levels.count {
            
            difficultyLevel.accept(.max)
            return
        }
        
        difficultyLevel.accept(levels[currentLevel])
    }
    
    func reset() {
        
        currentLevel = 0
        difficultyLevel.accept(.default)
    }
    
    struct Difficulty {
        
        let gravity: Double
        let meteorCreation: Double
        
        static var `default`: Difficulty {
            .init(gravity: -1.5, meteorCreation: 0.9)
        }
        
        static var middle: Difficulty {
            .init(gravity: -2.2, meteorCreation: 0.4)
        }
        
        static var max: Difficulty {
            .init(gravity: -3, meteorCreation: 0.3)
        }
    }
}
