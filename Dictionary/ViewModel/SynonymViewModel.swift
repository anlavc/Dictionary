//
//  SynonymViewModel.swift
//  Dictionary
//
//  Created by Anıl AVCI on 10.02.2023.
//

import Foundation
class SynonymListViewModel {
    private let service = WebService()
    private var searchResult = [SynonymResultModel]()
  
    var synonyms = [SynonymResultModel]()
 
  

    func fetchSearchResult(_ searchText: String,completion: @escaping(Result<[SynonymResultModel],NetworkError>) -> ()) {
        guard let url = URL(string: "\(ApiConstrants.synonymUrl)\(searchText)") else {return}
        let resource = Resource<[SynonymResultModel]> (url: url)
        service.fetchData(resource: resource) { result in
            switch result {
            case .success(let data):
              
                self.synonyms = data.sorted { $0.score! < $1.score! }
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
