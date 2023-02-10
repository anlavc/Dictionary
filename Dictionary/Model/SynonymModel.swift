//
//  SynonymModel.swift
//  Dictionary
//
//  Created by Anıl AVCI on 10.02.2023.
//

import Foundation
struct SynonymResultModel: Codable {
    let word: String?
    let score: Int?
}
typealias SynonymModel = [SynonymResultModel]
