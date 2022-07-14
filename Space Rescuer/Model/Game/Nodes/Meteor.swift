//
//  Meteor.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import SpriteKit

class Meteor: SKSpriteNode {
    init(size: CGSize, color: UIColor) {
        let texture = SKTexture(imageNamed: .meteor)
        super.init(texture: texture, color: .clear, size: size)
        
        name = .meteor
        addColorAnimation(color: color)
        setUpPhysics(texture: texture)
    }
    
    convenience init(parentFrameSize: CGSize, meteorSize: CGSize, color: UIColor) {
        self.init(size: meteorSize, color: color)
        
        position.x = CGFloat.random(in: -parentFrameSize.width/2...parentFrameSize.width/2)
        position.y = parentFrameSize.height/2 + size.height
    }
    
    convenience init(parentFrameSize: CGSize, color: UIColor) {
        let widthAndHeigth = Int.random(in: 20...90)

        self.init(parentFrameSize: parentFrameSize, meteorSize:
                    CGSize(width: widthAndHeigth, height: widthAndHeigth), color: color)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addColorAnimation(color: UIColor) {
        run(SKAction.colorize(with: color, colorBlendFactor: 0.2, duration: 0))
    }
    
    private func setUpPhysics(texture: SKTexture) {
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        
        physicsBody?.categoryBitMask = .meteor
        physicsBody?.collisionBitMask = .spaceShip | .meteor
        physicsBody?.contactTestBitMask = .spaceShip
        
        physicsBody?.angularVelocity = CGFloat.random(in: -5...5)
        physicsBody?.velocity.dx = CGFloat.random(in: -100...100)
    }
}

//MARK: - Meteor creation action
extension Meteor {
    static func addMeteorCreationAction(to parent: SKScene, creationDuration: TimeInterval, color: UIColor = [UIColor.red, UIColor.yellow, UIColor.green, UIColor.clear].randomElement()!) {
        let meteorSequensAction = SKAction.sequence([
            SKAction.run {
                let meteor = Meteor(parentFrameSize: parent.frame.size, color: color)
                meteor.zPosition = 1
                parent.addChild(meteor)
            },
            SKAction.wait(forDuration: creationDuration, withRange: 0.5)
        ])
        
        parent.run(SKAction.repeatForever(meteorSequensAction), withKey: .meteorFallingAction)
    }
}
