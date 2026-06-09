//
//  SearchResultDTO.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

struct SearchResultDTO: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}
