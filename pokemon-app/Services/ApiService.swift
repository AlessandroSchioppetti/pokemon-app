//
//  ApiService.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import UIKit

class ApiService {
    static let shared: ApiService = ApiService()
    
    func getCodable<T: Codable>(ofType: T.Type, from urlString: String, completion: @escaping (Result<T,Error>) -> Void) {
        getRequest(from: urlString) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImage(from urlString: String, completion: @escaping (Result<UIImage,Error>) -> Void) {
        getRequest(from: urlString) { result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)!
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRequest(from urlString: String, completion: @escaping ((Result<Data,Error>) -> Void)) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data {
                    completion(.success(data))
                }
            }
            task.resume()
        }
    }
}
