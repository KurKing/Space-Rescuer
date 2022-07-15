//
//  GameViewController.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import UIKit
import SpriteKit
import SnapKit
import RxSwift
import RxCocoa

class GameViewController: UIViewController {
    
    let gameScene: GameScene
    let menuView = MenuView()
    
    var viewModel: GameViewModelProtocol? {
        didSet {
            viewModel?.gameScene = gameScene
            
            viewModel?.score.subscribe(onNext: { [weak self] score in
                self?.scoreView.scoreLabelText = "x\(score)"
            }).disposed(by: disposeBag)
            
            viewModel?.isMenuHidden.subscribe(onNext: { [weak self] isHidden in
                self?.menuView.isHidden = isHidden
            }).disposed(by: disposeBag)
        }
    }
    
    private let scoreView = ScoreView()
    private let disposeBag = DisposeBag()
    
    init(gameScene: GameScene = GameScene()) {
        self.gameScene = gameScene
        super.init(nibName: nil, bundle: nil)
        
        view.rx.observe(CGRect.self, "bounds")
            .compactMap({ $0 })
            .subscribe(onNext: {
                gameScene.size = $0.size
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroungImage()
        setupScene()
        addScoreLabel()
        
        menuView.delegate = self
        view.addSubview(menuView)
        menuView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
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
        let sceneView = SKView(frame: view.frame)
        sceneView.ignoresSiblingOrder = false
        sceneView.backgroundColor = .clear
        
        view.addSubview(sceneView)
        sceneView.presentScene(gameScene)
    }
    
    func addScoreLabel() {
        view.addSubview(scoreView)
        scoreView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(3)
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(50)
        }
    }
}
