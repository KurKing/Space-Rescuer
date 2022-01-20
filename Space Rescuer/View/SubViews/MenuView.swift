//
//  MenuView.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import UIKit

class MenuView: UIView {

    var delegate: MenuViewDelegate?
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
    
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.setBackgroundImage(UIImage(named: .playButton), for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton(type: .system)
    
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.setBackgroundImage(UIImage(named: .gearButton), for: .normal)
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    func setUp() {
        layer.cornerRadius = .menuViewCornerRadius
        backgroundColor = .menuBgColor
        
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.center.equalToSuperview()
//            $0.top.equalToSuperview().offset(20)
        }
        
//        addSubview(settingButton)
//        settingButton.snp.makeConstraints {
//            $0.size.equalTo(80)
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-20)
//        }
        
        snp.makeConstraints {
            $0.width.equalTo(180)
            $0.height.equalTo(180)
        }
    }
    
    @objc private func playButtonPressed() {
        delegate?.playButtonPressed()
    }
    
    @objc private func settingsButtonPressed() {
        delegate?.settingsButtonPressed()
    }

}
