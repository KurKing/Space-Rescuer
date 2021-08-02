//
//  CheatCodeCollectionViewCell.swift
//  Space Rescuer
//
//  Created by Oleksiy on 02.08.2021.
//

import UIKit

class CheatCodeCollectionViewCell: UICollectionViewCell {
    
    var buttonPressedComplition: ((String)->())?
    
    private let textField: UITextField = {
        let textField = UITextField()
        
        textField.attributedPlaceholder = NSAttributedString(string: "Enter cheat code", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = UIFont(name: .customFontName, size: 25)
        textField.textColor = .black
        textField.backgroundColor = .white
        
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.setBackgroundImage(UIImage(named: .playButton), for: .normal)
        
        return button
    }()
    
    override var canBecomeFocused: Bool { false }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .clear

        contentView.addSubview(textField)
        contentView.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonPressed), for:  .touchUpInside)
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(7)
            $0.trailing.equalTo(button.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalTo(textField.snp.centerY)
            $0.trailing.equalToSuperview().offset(-7)
            $0.size.equalTo(40)
        }
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
        if let complition = buttonPressedComplition {
            guard let text = textField.text, let text = text.removeWhiteSpaces()  else {
                textField.text = ""
                return
            }
            
            complition(text)
        }
        
        textField.text = ""
        endEditing(true)
    }
}
