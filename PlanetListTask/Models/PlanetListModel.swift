//
//  PlanetList.swift
//  PlanetListTask
//
//  Created by Prajakta on 09/05/23.
//

import Foundation

struct PlanetList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let planet: [Planet]?
    enum CodingKeys: String, CodingKey {
        case planet = "results"
        case count, next, previous
    }
}

// MARK: - Result
struct Planet: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String?
    let climate, gravity, terrain, surfaceWater: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}


