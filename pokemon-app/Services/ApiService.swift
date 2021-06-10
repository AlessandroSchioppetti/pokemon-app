//
//  ApiService.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import Foundation

class ApiService {
    static let shared: ApiService = ApiService()
    
    func getRequest<T: Codable>(urlString: String, type: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let dataIn = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(T.self, from: dataIn)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
