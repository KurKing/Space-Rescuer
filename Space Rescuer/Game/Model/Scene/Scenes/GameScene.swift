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
    private let difficulty = GameDifficulty()
    private var isAstronautCollisionEnabled = true
    
    private var isStarsCreated = false
    
    private let disposeBag = DisposeBag()
    
    override init() {
        
        super.init(size: .zero)
        
        scaleMode = .aspectFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        startObserving()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        setUpPhysics()
        
        spaceShip.zPosition = 1
        addChild(spaceShip)
        
        Astronaut.addAstronautCreationAction(to: self)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        
        super.didChangeSize(oldSize)
        
        guard size.height != 0, !isStarsCreated else {
            return
        }
        
        createStars()
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
        
        DispatchQueue.main.async {
            self.didBeginInternal(contact)
        }
    }
    
    private func didBeginInternal(_ contact: SKPhysicsContact) {
        
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
        
        guard isCollisionActivated else { return false }
        
        let aBitMask = contact.bodyA.categoryBitMask
        let bBitMask = contact.bodyB.categoryBitMask
        
        return (aBitMask == .spaceShip && bBitMask == .meteor)
        || (bBitMask == .spaceShip && aBitMask == .meteor)
    }
}

//MARK: - GameSceneProtocol
extension GameScene: GameSceneProtocol {
    
    var gameEvent: Observable<GameEvent> {
        _gameEvents.asObservable()
    }
    
    func increaseDifficulty() {
        difficulty.increase()
    }
    
    func startNewGame() {
        
        shouldTouchesBeChecked = true
        
        difficulty.reset()
        
        DispatchQueue.main.async {
            
            self.enumerateChildNodes(withName: .astronaut) { (node, _) in
                node.removeFromParent()
            }
        }
    }
}

//MARK: - SetUp
private extension GameScene {
    
    func createStars() {
        
        if let stars = SKSpriteNode(fileNamed: "Stars") {
            
            stars.position = CGPoint(x: 0, y: size.height)
            stars.zPosition = 0
            addChild(stars)
            
            isStarsCreated = true
        }
    }
    
    func setUpPhysics() {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
    }
    
    func startObserving() {
    
        difficulty.difficultyLevel
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] difficulty in
                
                guard let self else { return }
                
                self.physicsWorld.gravity = .init(dx: 0, dy: difficulty.gravity)
                
                guard self.shouldTouchesBeChecked else { return }
                
                self.removeAction(forKey: .meteorFallingAction)
                Meteor.addMeteorCreationAction(to: self,
                                               creationDuration: difficulty.meteorCreation)
            }).disposed(by: disposeBag)
    }
}
