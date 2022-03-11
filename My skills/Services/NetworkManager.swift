//
//  NetworkManager.swift
//  My skills
//
//  Created by iMac on 24.02.2022.
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
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
        AF.request(Link.rickAndMorty.rawValue)
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
}
