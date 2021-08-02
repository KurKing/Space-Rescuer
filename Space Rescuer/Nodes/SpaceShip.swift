//
//  SpaceShip.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import SpriteKit

class SpaceShip: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: .redSpaceShip)
        super.init(texture: texture, color: .clear, size: SpaceShip.textureSize)
        
        name = .spaceShip
        setUpPhysics(texture: texture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move(to target: CGPoint){
        run(SKAction.move(to: target,
                          duration: timeForMoveCalculate(startPoint: position, finishPoint: target))
        )
    }
    
    private func timeForMoveCalculate(startPoint: CGPoint, finishPoint: CGPoint) -> TimeInterval {
        return TimeInterval(
            sqrt(pow(startPoint.x-finishPoint.x, 2)+pow(startPoint.y-finishPoint.y, 2))/800.0)
    }
    
    private func setUpPhysics(texture: SKTexture) {
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.isDynamic = false
        
        physicsBody?.categoryBitMask = .spaceShip
        physicsBody?.collisionBitMask = .meteor
        physicsBody?.contactTestBitMask = .meteor
    }
}

//MARK: - Texture Size
private extension SpaceShip {
    private static let spaceShipWidth = 50
    static let textureSize = CGSize(width: spaceShipWidth, height: spaceShipWidth*175/101)
}
