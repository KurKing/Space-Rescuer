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
    
    var viewModel: GameViewModelProtocol? {
        didSet {
            if let userDelegate = viewModel as? GameSceneDelegate {
                gameScene.userDelegate = userDelegate
            }
        }
    }
    
    let gameScene = GameScene()
    let menuView = MenuView()
    
    private let scoreView = ScoreView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroungImage()
        setupScene()
        addScoreLabel()
        
        menuView.delegate = self
        view.addSubview(menuView)
        menuView.setUp()
        menuView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

//MARK: - UIViewControllerProtocol
extension GameViewController: GameViewControllerProtocol {
    func hideMenu() {
        menuView.isHidden = true
    }
    
    func showMenu() {
        menuView.isHidden = false
    }
    
    func setScore(_ score: Int) {
        scoreView.setScore(score)
    }
    
    var gameSceneInstance: GameSceneProtocol {
        gameScene
    }
}

//MARK: - MenuViewDelegate
extension GameViewController: MenuViewDelegate {
    func playButtonPressed() {
        viewModel?.playButtonPressed()
    }
    
    func infoButtonPressed() {
        print("infoButtonPressed")
    }
}

//MARK: - Set up
private extension GameViewController {
    func setBackgroungImage() {
        let imageView = UIImageView(image: UIImage(named: .backgroungImageName))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupScene() {
        gameScene.setUp(size: view.bounds.size)
        
        let sceneView = SKView(frame: view.frame)
        sceneView.ignoresSiblingOrder = false
        sceneView.backgroundColor = .clear
        
        view.addSubview(sceneView)
        sceneView.presentScene(gameScene)
    }
    
    func addScoreLabel() {
        scoreView.setUp()
        view.addSubview(scoreView)
        scoreView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }
    }
}
