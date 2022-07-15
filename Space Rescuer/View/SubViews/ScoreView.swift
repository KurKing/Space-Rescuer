//
//  ScoreView.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import UIKit

class ScoreView: UIView {
    
    var scoreLabelText: String? {
        set {
            label.text = newValue
        }
        get {
            label.text
        }
    }
    
    private let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        guard let image = UIImage(named: .astronaut) else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(50)
            
            [$0.leading, $0.top, $0.bottom].forEach {
                $0.equalToSuperview()
            }
        }
        
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: .customFontName, size: 40)
        label.text = "x0"
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
