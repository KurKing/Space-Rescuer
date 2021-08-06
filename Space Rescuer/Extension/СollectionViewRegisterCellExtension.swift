//
//  СollectionViewRegisterCellExtension.swift
//  Space Rescuer
//
//  Created by Oleksiy on 06.08.2021.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(type: T.Type) where T: ReusableUICollectionViewCell {
        register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T where T: ReusableUICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Can not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
}
