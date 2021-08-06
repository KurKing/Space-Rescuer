//
//  ReusableUICollectionViewCell.swift
//  Space Rescuer
//
//  Created by Oleksiy on 06.08.2021.
//

import UIKit

protocol ReusableUICollectionViewCell: UIView {
    static var reusableIdentifier: String { get }
}

extension ReusableUICollectionViewCell {
    static var reusableIdentifier: String {
        NSStringFromClass(self)
    }
}

extension UICollectionViewCell: ReusableUICollectionViewCell {}
