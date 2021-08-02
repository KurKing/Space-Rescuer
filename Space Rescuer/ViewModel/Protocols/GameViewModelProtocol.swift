//
//  GameViewModelProtocol.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import Foundation

protocol GameViewModelProtocol {
    func playButtonPressed()
    var customizableViewModel: СustomizableViewModel { get }
}
