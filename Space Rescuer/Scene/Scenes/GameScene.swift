//
//  GameScene.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    weak var userDelegate: GameSceneDelegate?
    
    private let spaceShip = SpaceShip()
    
    func setUp(size: CGSize) {
        scaleMode = .aspectFill
        backgroundColor = .clear
        self.size = size
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    override func didMove(to view: SKView) {
        
        createStars()
        
        spaceShip.zPosition = 1
        addChild(spaceShip)
        
        Meteor.addMeteorCreationAction(to: self)
    }
    
    //MARK: - Touches
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            spaceShip.move(to: touch.location(in: self))
        }
    }
}

private extension GameScene {
    func createStars() {
        if let stars = SKSpriteNode(fileNamed: "Stars") {
            stars.position = CGPoint(x: 0, y: size.height / 2)
            stars.zPosition = 0
            addChild(stars)
        }
    }
}
