//
//  GameScene.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import SpriteKit
import GameplayKit
import RxSwift
import RxRelay

class GameScene: SKScene {
    
    private let spaceShip = SpaceShip()
    
    fileprivate let _gameEvents = PublishRelay<GameEvent>()
    
    private var shouldTouchesBeChecked = false
    private var isCollisionActivated = true
    private var currentDifficulty: TimeInterval = 0.5
    private var isAstronautCollisionEnabled = true
    
    override init() {
        
        super.init(size: .zero)
        
        scaleMode = .aspectFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        for i in [contact.bodyA, contact.bodyB] {
            
            if let node = i.node {
                
                if node.name == .meteor {
                    return
                }
            }
        }
        
        removeAstronaut(contact)
        
        if isAstronautCollisionEnabled {
            
            _gameEvents.accept(.pickedUpAstronaut)
            isAstronautCollisionEnabled = false
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] _ in
                self?.isAstronautCollisionEnabled = true
            }
        }
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
        _gameEvents.accept(.crashInMeteor)
    }
    
    private func isCollisionBetweenSpaceShipAndMeteorHappend(_ contact: SKPhysicsContact) -> Bool {
        
        let aBitMask = contact.bodyA.categoryBitMask
        let bBitMask = contact.bodyB.categoryBitMask
        
        return ((aBitMask == .spaceShip && bBitMask == .meteor)
                || (bBitMask == .spaceShip && aBitMask == .meteor)) && isCollisionActivated
    }
}

//MARK: - GameSceneProtocol
extension GameScene: GameSceneProtocol {
    
    var gameEvent: Observable<GameEvent> {
        _gameEvents.asObservable()
    }
    
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
