//
//  RickAndMorty.swift
//  My skills
//
//  Created by iMac on 17.02.2022.
//

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Hero]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
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
}

struct Location: Decodable {
    let name: String
}

enum Link: String {
    case rickAndMorty = "https://rickandmortyapi.com/api/character"
}
