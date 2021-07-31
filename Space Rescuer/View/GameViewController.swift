//
//  GameViewController.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import UIKit
import SpriteKit
import SnapKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroungImage()
        // TODO: Add delegate
        setupScene()
    }
    
    private func setBackgroungImage() {
        let imageView = UIImageView(image: UIImage(named: .backgroungImageName))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.setSizeEqualToSuperView()
    }
    
    private func setupScene(delegate: GameSceneDelegate? = nil) {
        let gameScene = GameScene()
        gameScene.userDelegate = delegate
        gameScene.scaleMode = .aspectFill
        gameScene.backgroundColor = .clear

        let sceneView = SKView()
        sceneView.ignoresSiblingOrder = false
        sceneView.backgroundColor = .clear

        view.addSubview(sceneView)
        sceneView.snp.setSizeEqualToSuperView()
        
        sceneView.presentScene(gameScene)
    }
}
