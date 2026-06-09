//
//  WeatherRepositoryImpl.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

class WeatherRepositoryImpl: WeatherRepository {
    private let remoteDataSource: WeatherAPIService
    
    init(remoteDataSource: WeatherAPIService = WeatherAPIServiceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getWeather(for query: String) async throws -> WeatherEntity {
        let dto = try await remoteDataSource.fetchWeather(query: query)
        return mapToEntity(dto)
    }
    
    func searchLocations(query: String) async throws -> [SearchResult] {
        let dtos = try await remoteDataSource.searchLocations(query: query)
        return dtos.map { mapToSearchResult($0) }
    }
    
    // MARK: - Mappers
    
    private func mapToEntity(_ dto: WeatherResponseDTO) -> WeatherEntity {
        let location = WeatherEntity.Location(
            name: dto.location.name,
            region: dto.location.region,
            country: dto.location.country,
            lat: dto.location.lat,
            lon: dto.location.lon
        )
        
        let current = WeatherEntity.Current(
            tempC: dto.current.temp_c,
            conditionText: dto.current.condition.text,
            conditionIcon: dto.current.condition.icon,
            conditionCode: dto.current.condition.code
        )
        
        let forecast = dto.forecast.forecastday.map { dayDTO -> ForecastDayEntity in
            let hours = (dayDTO.hour ?? []).map { hourDTO -> HourEntity in
                HourEntity(
                    time: hourDTO.time,
                    tempC: hourDTO.temp_c,
                    conditionText: hourDTO.condition.text,
                    conditionIcon: hourDTO.condition.icon,
                    conditionCode: hourDTO.condition.code
                )
            }
            return ForecastDayEntity(
                date: dayDTO.date,
                maxTempC: dayDTO.day.maxtemp_c,
                minTempC: dayDTO.day.mintemp_c,
                avgTempC: dayDTO.day.avgtemp_c,
                conditionText: dayDTO.day.condition.text,
                conditionIcon: dayDTO.day.condition.icon,
                conditionCode: dayDTO.day.condition.code,
                hours: hours
            )
        }
        
        return WeatherEntity(location: location, current: current, forecast: forecast)
    }
    
    private func mapToSearchResult(_ dto: SearchResultDTO) -> SearchResult {
        SearchResult(
            id: dto.id,
            name: dto.name,
            region: dto.region,
            country: dto.country,
            lat: dto.lat,
            lon: dto.lon
        )
    }
}
