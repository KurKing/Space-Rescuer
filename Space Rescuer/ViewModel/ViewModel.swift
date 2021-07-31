//
//  ViewModel.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import UIKit

class ViewModel {
    
    private weak var viewController: UIViewControllerProtocol?
    
    init(viewController: UIViewControllerProtocol?) {
        self.viewController = viewController
    }
}

//MARK: - GameSceneDelegate
extension ViewModel: GameSceneDelegate {

}
