//
//  StringValidationExtension.swift
//  Space Rescuer
//
//  Created by Oleksiy on 02.08.2021.
//

import Foundation

extension String {
    func removeWhiteSpaces() -> String? {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if string.isEmpty {
            return nil
        }
        return string
    }
}
