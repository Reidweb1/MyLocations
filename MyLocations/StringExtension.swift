//
//  StringExtension.swift
//  MyLocations
//
//  Created by Reid Weber on 11/5/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation

extension String {
    func validate() -> Bool {
        let regex = NSRegularExpression(pattern: "[^0-9\n]", options: nil, error: nil)
        let match = regex?.numberOfMatchesInString(self, options: nil, range: NSRange(location: 0, length: countElements(self)))
        if match > 0 {
            return false
        } else {
            return true
        }
    }
}