//
//  Optional + Ext.swift
//  Dictionary
//
//  Created by Anıl AVCI on 9.02.2023.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self == "" || self == nil || self == " "
    }
}
