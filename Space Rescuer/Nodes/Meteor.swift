//
//  Meteor.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import SpriteKit

class Meteor: SKSpriteNode {
    init(size: CGSize) {
        let texture = SKTexture(imageNamed: .meteor)
        super.init(texture: texture, color: .clear, size: size)
        
        addColorAnimation()
    }
    
    convenience init(parentFrameSize: CGSize, meteorSize: CGSize) {
        self.init(size: meteorSize)
        
        position.x = CGFloat.random(in: -frame.width/2...frame.width/2)
        position.y = frame.height/2 + size.height
    }
    
    convenience init(parentFrameSize: CGSize) {
        let widthAndHeigth = Int.random(in: 20...90)
        let meteorSize = CGSize(width: widthAndHeigth, height: widthAndHeigth)
        
        self.init(parentFrameSize: parentFrameSize, meteorSize: meteorSize)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addColorAnimation() {
        let randomColor = [UIColor.red, UIColor.yellow,
                           UIColor.green, UIColor.white].randomElement()!
        
        run(SKAction.colorize(with: randomColor, colorBlendFactor: 0.2, duration: 0))
    }
}

//MARK: - Meteor creation action
extension Meteor {
    static func addMeteorCreationAction(to parent: SKScene) {
        let meteorSequensAction = SKAction.sequence([
            SKAction.run {
                let meteor = Meteor(parentFrameSize: parent.frame.size)
                meteor.zPosition = 1
                parent.addChild(meteor)
            },
            SKAction.wait(forDuration: 0.5, withRange: 0.5)
        ])
        
        parent.run(SKAction.repeatForever(meteorSequensAction))
    }
}
