//
//  RickAndMorty.swift
//  My skills
//
//  Created by Artem Pavlov on 17.02.2022.
//

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Hero]
    
    init() {
        info = Info()
        results = []
    }
    
    init(rickAndMortyData: [String: Any]) {
        let infoDict = rickAndMortyData["info"] as? [String: Any] ?? [:]
        info = Info(value: infoDict)
        let heroes = rickAndMortyData["results"] as? [[String: Any]] ?? []
        results = heroes.compactMap { Hero(value: $0)
        }
    }
    
    static func getRickAndMorty(from value: Any) -> RickAndMorty {
        guard let data = value as? [String: Any] else { return RickAndMorty() }
        let rickAndMorty = RickAndMorty(rickAndMortyData: data)
        return rickAndMorty
    }
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
    
    init() {
        pages = 0
        next = ""
        prev = ""
    }
    
    init(value: [String: Any]) {
        pages = value["pages"] as? Int ?? 0
        next = value["next"] as? String
        prev = value["prev"] as? String
    }
}

struct Hero: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    
    init(value: [String: Any]) {
        id = value["id"] as? Int ?? 0
        name = value["name"] as? String ?? ""
        status = value["status"] as? String ?? ""
        species = value["species"] as? String ?? ""
        gender = value["gender"] as? String ?? ""
        
        let originDict = value["origin"] as? [String: String] ?? [:]
        origin = Location(value: originDict)
        
        let locationDict = value["location"] as? [String: String] ?? [:]
        location = Location(value: locationDict)
        
        image = value["image"] as? String ?? ""
        episode = value["episode"] as? [String] ?? []
        url = value["url"] as? String ?? ""
    }
    
    var description: String {
    """
    Имя: \(name)
    Статус персонажа: \(status)
    Раса: \(species)
    Пол: \(gender)
    Место рождения: \(origin.name)
    Текущее местоположение: \(location.name)
    """
    }
}

struct Location: Decodable {
    let name: String
    
    init(value: [String: String?]) {
        name = value["name"] as? String ?? ""
    }
}

enum Link: String {
    case rickAndMorty = "https://rickandmortyapi.com/api/character"
}

enum FetchingMethod {
    case automatic
    case withAlamofire
    case withCache
}
