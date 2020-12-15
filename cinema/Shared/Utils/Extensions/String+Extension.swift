//
//  String+Extension.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import Foundation

extension String {
    func isValid() -> Bool {
        return !self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
