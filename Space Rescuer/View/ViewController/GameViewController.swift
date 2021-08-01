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
    
    var viewModel: ViewModel? {
        didSet {
            gameScene.userDelegate = viewModel
        }
    }
    let gameScene = GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroungImage()
        setupScene()
    }
    
}

//MARK: - UIViewControllerProtocol
extension GameViewController: UIViewControllerProtocol {
    
}

//MARK: - Set up
private extension GameViewController {
    func setBackgroungImage() {
        let imageView = UIImageView(image: UIImage(named: .backgroungImageName))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.setSizeEqualToSuperView()
    }
    
    func setupScene() {
        gameScene.setUp(size: view.bounds.size)
        
        let sceneView = SKView(frame: view.frame)
        sceneView.ignoresSiblingOrder = false
        sceneView.backgroundColor = .clear
        
        view.addSubview(sceneView)
        sceneView.presentScene(gameScene)
    }
}
