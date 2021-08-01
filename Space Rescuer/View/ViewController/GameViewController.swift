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
    
    private(set) var setScoreLabelText: ((Int)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroungImage()
        setupScene()
        addScoreLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.startGameButtonPressed()
    }
    
}

//MARK: - UIViewControllerProtocol
extension GameViewController: GameViewControllerProtocol {
    func setScore(_ score: Int) {
        if let closure = setScoreLabelText {
            closure(score)
        }
    }
    
    var gameSceneInstance: GameSceneProtocol {
        gameScene
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
        let scoreView = UIView()
        
        guard let image = UIImage(named: .astronaut) else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        scoreView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(50)
            
            [$0.leading, $0.top, $0.bottom].forEach {
                $0.equalToSuperview()
            }
        }
        
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: .customFontName, size: 40)
        label.text = "x0"
        
        setScoreLabelText = { score in
            label.text = "x\(score)"
        }
        
        scoreView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        view.addSubview(scoreView)
        scoreView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }
    }
}
