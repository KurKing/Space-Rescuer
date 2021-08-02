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
    private var shouldTouchesBeChecked = false
    private var currentDifficulty: TimeInterval = 0.5
    
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
        
        Astronaut.addAstronautCreationAction(to: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            spaceShip.move(to: touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPaused {
            isPaused = false
        }
    }
}

//MARK: - Physics
extension GameScene: SKPhysicsContactDelegate {
    
    override func didSimulatePhysics() {
        for i in [String.meteor, String.astronaut] {
            enumerateChildNodes(withName: i) { (node, stop) in
                let heigth = UIScreen.main.bounds.height
                
                if node.position.y < -heigth/2-node.frame.height {
                    node.removeFromParent()
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if !shouldTouchesBeChecked { return }
        
        if isCollisionBetweenSpaceShipAndMeteorHappend(contact) {
            meteorCollisionHappened()
            return
        }
        
        removeAstronaut(contact)
        userDelegate?.astronautCollisionHappened()
    }
    
    private func removeAstronaut(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name ?? "" == .astronaut {
            contact.bodyA.node?.removeFromParent()
            return
        }
        contact.bodyB.node?.removeFromParent()
    }
    
    private func meteorCollisionHappened() {
        removeAction(forKey: .meteorFallingAction)
        enumerateChildNodes(withName: .meteor) { node, _ in
            node.removeFromParent()
        }
        shouldTouchesBeChecked = false
        userDelegate?.meteorCollisionHappened()
    }
    
    private func isCollisionBetweenSpaceShipAndMeteorHappend(_ contact: SKPhysicsContact) -> Bool {
        let aBitMask = contact.bodyA.categoryBitMask
        let bBitMask = contact.bodyB.categoryBitMask
        
        return ((aBitMask == .spaceShip && bBitMask == .meteor) || (bBitMask == .spaceShip && aBitMask == .meteor)) && !Cheats.shared.isCollisionCheatCodeActivated
    }
    
}

//MARK: - GameSceneProtocol
extension GameScene: GameSceneProtocol {
    func increaseDifficulty() {
        currentDifficulty -= 0.1
        removeAction(forKey: .meteorFallingAction)
        Meteor.addMeteorCreationAction(to: self, creationDuration: currentDifficulty)
    }
    
    func startNewGame() {
        currentDifficulty = 0.5
        Meteor.addMeteorCreationAction(to: self, creationDuration: currentDifficulty)
        shouldTouchesBeChecked = true
        
        enumerateChildNodes(withName: .astronaut) { (node, _) in
            node.removeFromParent()
        }
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
