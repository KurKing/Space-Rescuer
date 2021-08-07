//
//  GameNodeCollectionViewCell.swift
//  Space Rescuer
//
//  Created by Oleksiy on 07.08.2021.
//

import UIKit
import SpriteKit

class GameNodeCollectionViewCell: UICollectionViewCell {
    
    private var sceneContainer: SKView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ specifications: SpaceShipSpecifications) {
        recreateContainer()
        sceneContainer?.presentScene(ContainerScene(size: frame.size, spaceShipSpecifications: specifications))
    }
    
    func setData(_ color: MeteorColor) {
        recreateContainer()
        sceneContainer?.presentScene(ContainerScene(size: frame.size, meteorColor: color))
    }
    
    var newSceneView: SKView {
        let sceneView = SKView(frame: self.contentView.frame)
        sceneView.ignoresSiblingOrder = false
        sceneView.backgroundColor = .clear
        return sceneView
    }
    
    private func recreateContainer() {
        sceneContainer?.removeFromSuperview()
        sceneContainer = newSceneView
        contentView.addSubview(sceneContainer!)
        addConstraints()
    }
    
    private func addConstraints() {
        sceneContainer?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private class ContainerScene: SKScene {
        private var spaceShipSpecifications: SpaceShipSpecifications?
        private var meteorColor: MeteorColor?
        
        private override init(size: CGSize) {
            super.init(size: size)
            
            scaleMode = .aspectFill
            backgroundColor = .clear
            anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
        
        convenience init(size: CGSize, meteorColor: MeteorColor) {
            self.init(size: size)
            self.meteorColor = meteorColor
            self.spaceShipSpecifications = nil
        }
        
        convenience init(size: CGSize, spaceShipSpecifications: SpaceShipSpecifications) {
            self.init(size: size)
            self.spaceShipSpecifications = spaceShipSpecifications
            self.meteorColor = nil
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func didMove(to view: SKView) {
            
            if let specifications = spaceShipSpecifications {
                let spaceShip = SpaceShip()
                spaceShip.setSpecifications(specifications)
                spaceShip.size = SpaceShip.countSizeForWidth(size.width/2.5)
                addChild(spaceShip)
            }
            
            if let meteorColor = meteorColor {
                let meteor = Meteor(size: frame.size * CGFloat.random(in: 0.7...0.8), color: meteorColor.uiColor)
                meteor.physicsBody?.isDynamic = false
                addChild(meteor)
            }
            
            return
        }
    }
}
