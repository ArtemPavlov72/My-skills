//
//  NetworkManager.swift
//  My skills
//
//  Created by Artem Pavlov on 24.02.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData(from url: String, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(rickAndMorty))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
    
    func fetchDataWithAlamofire(from url: String, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let rickAndMorty = RickAndMorty.getRickAndMorty(from: value)
                    DispatchQueue.main.async {
                        completion(.success(rickAndMorty))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
                
            }
    }
}

class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func loadImage(from url: String?) -> Data? {
        guard let imageURL = URL(string: url ?? "") else {return nil}
        return try? Data(contentsOf: imageURL)
    }
    
    func loadImageWithAlamofire(from url: String, completion: @escaping(Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func loadImageWithCache(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else {return}
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
