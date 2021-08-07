//
//  UIImageViewExtension.swift
//  Space Rescuer
//
//  Created by Oleksiy on 07.08.2021.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
