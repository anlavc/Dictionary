//
//  Molde.swift
//  Dictionary
//
//  Created by Anıl AVCI on 8.02.2023.
//

import Foundation

// MARK: - DictionaryElement
struct SearchResultModel: Codable {
    let word, phonetic: String?
    let meanings: [Meaning]
    let sourceUrls: [String]
   // let phonetics: [Phonetic]
}


// MARK: - Meaning
struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

// MARK: - Definition
struct Definition: Codable {
    let definition: String
    let example: String?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    let text: String
    let audio: String
    let sourceURL: String?
   
}
