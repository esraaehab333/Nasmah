//
//  DIContainer.swift
//  Nasmah
//
//  Created by Nemo on 09/06/2026.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
    private init() {}

    // MARK: - Data Sources
    private func makeWeatherAPIService() -> WeatherAPIService {
        WeatherAPIServiceImpl()
    }

    private func makeCoreDataManager() -> CoreDataManager {
        .shared
    }

    // MARK: - Repositories
    private func makeWeatherRepository() -> WeatherRepository {
        WeatherRepositoryImpl(remoteDataSource: makeWeatherAPIService())
    }

    private func makeSavedLocationsRepository() -> SavedLocationsRepository {
        SavedLocationsRepositoryImpl(localDataSource: makeCoreDataManager())
    }

    // MARK: - Use Cases (public factory methods)
    func makeFetchWeatherUseCase() -> FetchWeatherUseCaseProtocol {
        FetchWeatherUseCase(repository: makeWeatherRepository())
    }

    func makeFetchForecastHoursUseCase() -> FetchForecastHoursUseCaseProtocol {
        FetchForecastHoursUseCase(repository: makeWeatherRepository())
    }

    func makeSearchLocationsUseCase() -> SearchLocationsUseCaseProtocol {
        SearchLocationsUseCase(repository: makeWeatherRepository())
    }

    func makeSaveLocationUseCase() -> SaveLocationUseCaseProtocol {
        SaveLocationUseCase(repository: makeSavedLocationsRepository())
    }

    func makeFetchSavedLocationsUseCase() -> FetchSavedLocationsUseCaseProtocol {
        FetchSavedLocationsUseCase(repository: makeSavedLocationsRepository())
    }

    func makeDeleteLocationUseCase() -> DeleteLocationUseCaseProtocol {
        DeleteLocationUseCase(repository: makeSavedLocationsRepository())
    }
}
