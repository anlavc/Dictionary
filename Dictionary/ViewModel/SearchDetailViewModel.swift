//
//  SearchDetailViewModel.swift
//  Dictionary
//
//  Created by Anıl AVCI on 8.02.2023.
//

import Foundation

class DetailListViewModel {
    private let service = WebService()
    private var searchResult = [SearchResultModel]()
  
    var meanings = [Meaning]()
    func numberOfRowsSection(_ section: Int) -> Int {
        return meanings.count
    }
    func cellForRowAt(_ index: Int) -> HeaderViewModel {
        let result = searchResult[index]
        return HeaderViewModel(searchResult: result)
    }

    func fetchSearchResult(_ searchText: String,completion: @escaping(Result<[SearchResultModel],NetworkError>) -> ()) {
        guard let url = URL(string: "\(ApiConstrants.searchUrl)\(searchText)") else {return}
        let resource = Resource<[SearchResultModel]> (url: url)
        service.fetchData(resource: resource) { result in
            switch result {
            case .success(let data):
                self.searchResult = data
                self.meanings = data[0].meanings
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

    

