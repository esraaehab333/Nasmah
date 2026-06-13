//
//  WeatherAPIService.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation
import Alamofire

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
    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func fetchWeather(query: String) async throws -> WeatherResponseDTO {
        let parameters: Parameters = [
            "key":  Config.apiKey,
            "q":    query,
            "days": "3"
        ]

        return try await withCheckedThrowingContinuation { continuation in
            session
                .request("\(Config.baseURL)/forecast.json", parameters: parameters)
                .validate()
                .responseDecodable(of: WeatherResponseDTO.self) { response in
                    switch response.result {
                    case .success(let dto):
                        continuation.resume(returning: dto)
                    case .failure(let error):
                        if let underlying = error.underlyingError as? DecodingError {
                            continuation.resume(throwing: WeatherAPIError.decodingError(underlying))
                        } else if response.response == nil {
                            continuation.resume(throwing: WeatherAPIError.invalidURL)
                        } else {
                            continuation.resume(throwing: WeatherAPIError.badServerResponse)
                        }
                    }
                }
        }
    }

    func searchLocations(query: String) async throws -> [SearchResultDTO] {
        let parameters: Parameters = [
            "key": Config.apiKey,
            "q":   query
        ]

        return try await withCheckedThrowingContinuation { continuation in
            session
                .request("\(Config.baseURL)/search.json", parameters: parameters)
                .validate()
                .responseDecodable(of: [SearchResultDTO].self) { response in
                    switch response.result {
                    case .success(let dto):
                        continuation.resume(returning: dto)
                    case .failure(let error):
                        if let underlyingError = error.underlyingError as? DecodingError {
                            continuation.resume(throwing: WeatherAPIError.decodingError(underlyingError))
                        } else if response.response == nil {
                            continuation.resume(throwing: WeatherAPIError.invalidURL)
                        } else {
                            continuation.resume(throwing: WeatherAPIError.badServerResponse)
                        }
                    }
                }
        }
    }
}
