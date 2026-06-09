//
//  WeatherAPIService.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

protocol WeatherAPIService {
    func fetchWeather(query: String) async throws -> WeatherResponseDTO
    func searchLocations(query: String) async throws -> [SearchResultDTO]
}

enum WeatherAPIError: Error, LocalizedError {
    case invalidURL
    case badServerResponse
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The API URL could not be constructed."
        case .badServerResponse:
            return "The server returned an invalid or unsuccessful response."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}

class WeatherAPIServiceImpl: WeatherAPIService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchWeather(query: String) async throws -> WeatherResponseDTO {
        var components = URLComponents(string: "\(Config.baseURL)/forecast.json")
        components?.queryItems = [
            URLQueryItem(name: "key", value: Config.apiKey),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "days", value: "3")
        ]
        
        guard let url = components?.url else {
            throw WeatherAPIError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw WeatherAPIError.badServerResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherResponseDTO.self, from: data)
        } catch {
            throw WeatherAPIError.decodingError(error)
        }
    }
    
    func searchLocations(query: String) async throws -> [SearchResultDTO] {
        var components = URLComponents(string: "\(Config.baseURL)/search.json")
        components?.queryItems = [
            URLQueryItem(name: "key", value: Config.apiKey),
            URLQueryItem(name: "q", value: query)
        ]
        
        guard let url = components?.url else {
            throw WeatherAPIError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw WeatherAPIError.badServerResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([SearchResultDTO].self, from: data)
        } catch {
            throw WeatherAPIError.decodingError(error)
        }
    }
}
