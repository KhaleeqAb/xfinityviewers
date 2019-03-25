//
//  String+Extension.swift
//  XfinityViewers
//
//  Created by Khaleeq Abdul on 3/22/19.
//  Copyright © 2019 Xfinity. All rights reserved.
//

import Foundation

extension String {
    
    func splitStringWithSeparator(separator: Character?) -> [Substring] {
        guard let _separator = separator else {
            return [Substring]()
        }
        return self.split(separator: _separator)
    }
    
    /// Extension to access localized string.
    ///
    /// - Returns: a localized localized string
    func localizedString(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
