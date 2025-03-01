//
//  InfoViewController.swift
//  Space Rescuer
//
//  Created by Oleksii on 01.03.2025.
//

import UIKit
import SwiftUI

class InfoViewController: UIHostingController<InfoView> {
    
    init() {
        super.init(rootView: InfoView())
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
