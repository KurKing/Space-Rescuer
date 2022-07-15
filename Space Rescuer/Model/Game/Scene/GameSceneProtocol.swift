//
//  GameSceneProtocol.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import Foundation
import RxSwift

protocol GameSceneProtocol: AnyObject {
    var gameEvent: Observable<GameEvent> { get }
    func startNewGame()
    func increaseDifficulty()
}
