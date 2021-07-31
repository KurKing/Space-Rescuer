//
//  ConstraintViewDSL Extension.swift
//  Space Rescuer
//
//  Created by Oleksiy on 31.07.2021.
//

import SnapKit

extension ConstraintViewDSL {
    func setSizeEqualToSuperView() {
        self.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
