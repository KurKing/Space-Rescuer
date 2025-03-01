//
//  GameViewModelProtocol.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import Foundation
import RxSwift

protocol GameViewModelProtocol {
    
    var gameScene: GameSceneProtocol? { get set }
    var score: Observable<Int> { get }
    var isMenuHidden: Observable<Bool> { get }
    func playButtonPressed()
}
