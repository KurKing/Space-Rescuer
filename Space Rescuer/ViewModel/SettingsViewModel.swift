//
//  SettingsViewModel.swift
//  Space Rescuer
//
//  Created by Oleksiy on 02.08.2021.
//

import Foundation

class SettingsViewModel {
    
    private weak var viewModelToSetup: СustomizableViewModel?
    weak var uiController: SettingsViewControllerProtocol?
    private(set) var currentSettings: SettingsModel
    
    init(viewModelToSetup: СustomizableViewModel) {
        self.viewModelToSetup = viewModelToSetup
        currentSettings = SettingsModel.defaultSettings
    }
    
    func enterCheatCode(_ code: String) {
        if code.hash == 3720932424078554781 {
            currentSettings.isCheatCodeEntered = true
            uiController?.showSuccessCheatCodeAlert()
        }
    }
    
    func willDismiss() {
        viewModelToSetup?.customize(with: currentSettings)
    }
}
