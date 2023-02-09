//
//  HeaderViewModel.swift
//  Dictionary
//
//  Created by Anıl AVCI on 10.02.2023.
//

import Foundation

struct HeaderViewModel {
    
    let searchResult: SearchResultModel
    
    var word: String {
        return searchResult.word ?? "yok"
    }
    var phonetic: String {
        return searchResult.phonetic ?? ""
    }
    
}
