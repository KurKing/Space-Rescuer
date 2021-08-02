//
//  GameViewModel.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import UIKit

class GameViewModel {
    
    var isScoreCountingEnable = true
    private var score = 0 {
        didSet {
            viewController?.setScore(score)
            increaseDifficultyIfNeeded()
        }
    }
    
    private let gameScene: GameSceneProtocol?
    private let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

    private(set) weak var viewController: GameViewControllerProtocol?
    
    init(viewController: GameViewControllerProtocol?) {
        self.viewController = viewController
        gameScene = viewController?.gameSceneInstance
    }
    
    private func increaseDifficultyIfNeeded() {
        if [10,25,40].contains(score) {
            gameScene?.increaseDifficulty()
        }
    }
}

//MARK: - GameViewModelProtocol
extension GameViewModel: GameViewModelProtocol {

}

//MARK: - MenuViewDelegate
extension GameViewModel: MenuViewDelegate {
    func settingsButtonPressed() {
        print("settingsButtonPressed")
    }
    
    func playButtonPressed() {
        score = 0
        viewController?.hideMenu()
        gameScene?.startNewGame()
    }
}

//MARK: - GameSceneDelegate
extension GameViewModel: GameSceneDelegate {
    func astronautCollisionHappened() {
        if isScoreCountingEnable {
            lightImpactFeedbackGenerator.impactOccurred()
            score += 1
            isScoreCountingEnable = false
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] _ in
                self?.isScoreCountingEnable = true
            }
        }
    }
    
    func meteorCollisionHappened() {
        score = 0
        heavyImpactFeedbackGenerator.impactOccurred()
        viewController?.showMenu()
    }
}
