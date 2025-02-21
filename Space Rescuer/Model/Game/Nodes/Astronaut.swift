//
//  Astronaut.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import SpriteKit

class Astronaut: SKSpriteNode {
    
    init(size: CGSize) {
        
        let texture = SKTexture(imageNamed: .astronaut)
        super.init(texture: texture, color: .clear, size: size)
        
        name = .astronaut
        setUpPhysics(texture: texture)
    }
    
    convenience init(parentFrameSize: CGSize, size: CGSize) {
        
        self.init(size: size)
        
        position.x = CGFloat.random(in: -parentFrameSize.width/2...parentFrameSize.width/2)
        position.y = parentFrameSize.height/2 + size.height
    }
    
    convenience init(parentFrameSize: CGSize) {
        
        let defaultWidth = 30
        
        self.init(parentFrameSize: parentFrameSize, size:
                    CGSize(width: defaultWidth, height: defaultWidth*913/662))
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    private func setUpPhysics(texture: SKTexture) {
        
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        
        physicsBody?.categoryBitMask = .astronaut
        physicsBody?.collisionBitMask = .spaceShip | .meteor | .astronaut
        physicsBody?.contactTestBitMask = .spaceShip
        
        physicsBody?.angularVelocity = CGFloat.random(in: -5...5)
    }
}

//MARK: - Astronaut creation action
extension Astronaut {
    
    static func addAstronautCreationAction(to parent: SKScene) {
        
        let astronautSequensAction = SKAction.sequence([
            
            SKAction.run {
                
                let astronaut = Astronaut(parentFrameSize: parent.frame.size)
                astronaut.zPosition = 1
                parent.addChild(astronaut)
            },
            SKAction.wait(forDuration: 1.1, withRange: 0.5)
        ])
        
        parent.run(SKAction.repeatForever(astronautSequensAction))
    }
}
