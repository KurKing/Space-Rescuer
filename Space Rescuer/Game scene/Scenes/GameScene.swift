//
//  GameScene.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var userDelegate: GameSceneDelegate?
    
    func setUp(size: CGSize) {
        scaleMode = .aspectFill
        backgroundColor = .clear
        self.size = size
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    //MARK: - didMove
    override func didMove(to view: SKView) {
        
        if let stars = SKSpriteNode(fileNamed: "Stars") {
            stars.position = CGPoint(x: 0, y: size.height / 2)
            stars.zPosition = 0
            addChild(stars)
        }
        
    }
    
}
