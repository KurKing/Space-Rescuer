//
//  GameViewControllerProtocol.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import UIKit

protocol GameViewControllerProtocol: AnyObject {
    var gameSceneInstance: GameSceneProtocol { get }
    func setScore(_ score: Int)
}
