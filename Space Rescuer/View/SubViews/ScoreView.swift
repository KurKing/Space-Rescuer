//
//  ScoreView.swift
//  Space Rescuer
//
//  Created by Oleksiy on 01.08.2021.
//

import UIKit

class ScoreView: UIView {
    
    private let label = UILabel()

    func setUp() {
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
    
    func setScore(_ score: Int) {
        label.text = "x\(score)"
    }

}
