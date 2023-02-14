//
//  ArrayFilter + Ext.swift
//  Dictionary
//
//  Created by Anıl AVCI on 14.02.2023.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted}
    }
}
