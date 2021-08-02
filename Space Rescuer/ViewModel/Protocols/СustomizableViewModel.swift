//
//  СustomizableViewModel.swift
//  Space Rescuer
//
//  Created by Oleksiy on 02.08.2021.
//

import Foundation

protocol СustomizableViewModel: AnyObject {
    func customize(with settings: SettingsModel)
}
