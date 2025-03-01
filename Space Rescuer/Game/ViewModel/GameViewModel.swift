//
//  GameViewModel.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import RxSwift
import RxRelay
import UIKit

class GameViewModel {
    
    weak var gameScene: GameSceneProtocol? {
        
        didSet {
            setupSubscribersForGameScene()
        }
    }
    
    fileprivate let _score = BehaviorRelay(value: 0)
    fileprivate let _isMenuHidden = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()
    
    private let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    init() {
        score.filter({ [10,25,40].contains($0) })
            .subscribe(onNext: { [weak self] _ in
                self?.gameScene?.increaseDifficulty()
            }).disposed(by: disposeBag)
    }
    
    private func setupSubscribersForGameScene() {
        
        gameScene?.gameEvent.subscribe(onNext: { [weak self] gameEvent in
            
            guard let self else { return }
            
            switch gameEvent {
            case .pickedUpAstronaut:
                
                self.lightImpactFeedbackGenerator.impactOccurred()
                self._score.accept(self._score.value + 1)
            case .crashInMeteor:
                
                self.heavyImpactFeedbackGenerator.impactOccurred()
                self._isMenuHidden.accept(false)
            }
        }).disposed(by: disposeBag)
    }
}

//MARK: - GameViewModelProtocol
extension GameViewModel: GameViewModelProtocol {
    
    var isMenuHidden: Observable<Bool> { _isMenuHidden.asObservable() }
    var score: Observable<Int> { _score.asObservable() }
    
    func playButtonPressed() {
        
        _score.accept(0)
        _isMenuHidden.accept(true)
        gameScene?.startNewGame()
    }
}
