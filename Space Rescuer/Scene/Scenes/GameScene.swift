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
        setUpPhysics()
        
        spaceShip.zPosition = 1
        addChild(spaceShip)
        
        Meteor.addMeteorCreationAction(to: self, creationDuration: 0.5)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            spaceShip.move(to: touch.location(in: self))
        }
    }
}

//MARK: - Physics
extension GameScene: SKPhysicsContactDelegate {
    
    override func didSimulatePhysics() {
        enumerateChildNodes(withName: "meteor") { (meteor, stop) in
            let heigth = UIScreen.main.bounds.height
            
            if meteor.position.y < -heigth/2-meteor.frame.height {
                meteor.removeFromParent()
            }
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if isCollisionHappend(contact) {
            // TODO: LOSE
            removeAllActions()
        }
    }
    
    private func isCollisionHappend(_ contact: SKPhysicsContact) -> Bool {
        return (contact.bodyA.categoryBitMask == .spaceShip || contact.bodyB.categoryBitMask == .spaceShip) && !Cheats.isCheatCodeEntered
    }

}

//MARK: - SetUp
private extension GameScene {
    func createStars() {
        if let stars = SKSpriteNode(fileNamed: "Stars") {
            stars.position = CGPoint(x: 0, y: size.height / 2)
            stars.zPosition = 0
            addChild(stars)
        }
    }
    
    func setUpPhysics() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
    }
}
