
import Foundation

enum NetworkError: Error {
    case DecodingError
    case domainError
}
struct Resource<T: Codable> {
    let url: URL
}

struct WebService {
    func fetchData<T>(resource: Resource<T>, complation: @escaping(Result<T, NetworkError>) -> ()) {
       
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data, error == nil else {
                complation(.failure(.domainError))
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                complation(.success(result))
            } else {
                complation(.failure(.DecodingError))
            }
            guard let response = response as? HTTPURLResponse else {
                complation(.failure(.domainError))
                print(resource)
                return
            }
            response.statusCode > 200 ? complation(.failure(.domainError)) : nil
        }.resume()
    }
}
