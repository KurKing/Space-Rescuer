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
    
    private let infoButton: UIButton = {
        
        let button = UIButton(type: .system)
    
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.setBackgroundImage(UIImage(named: .questionButton), for: .normal)
        button.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    init() {
        
        super.init(frame: .zero)
        
        layer.cornerRadius = .menuViewCornerRadius
        backgroundColor = .menuBackgroundColor
        
        addSubview(playButton)
        playButton.snp.makeConstraints {
            
            $0.size.equalTo(120)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        addSubview(infoButton)
        infoButton.snp.makeConstraints {
            
            $0.size.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(playButton.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        snp.makeConstraints {
            $0.width.equalTo(180)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func playButtonPressed() {
        delegate?.playButtonPressed()
    }
    
    @objc private func infoButtonPressed() {
        delegate?.infoButtonPressed()
    }
}
