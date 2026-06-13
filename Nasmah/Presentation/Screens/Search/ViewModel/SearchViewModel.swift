//
//  SearchViewModel.swift
//  Nasmah
//

import Foundation
import Combine
import SwiftUI

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var searchResults: [SearchResult] = []
    @Published var savedLocations: [SavedLocation] = []
    @Published var isSearching: Bool = false
    @Published var errorMessage: String?

    // Injected from HomeViewModel so theme stays in sync with the home screen.
    var conditionCode: Int?

    private let searchUseCase: SearchLocationsUseCaseProtocol
    private let saveUseCase: SaveLocationUseCaseProtocol
    private let fetchSavedUseCase: FetchSavedLocationsUseCaseProtocol
    private let deleteUseCase: DeleteLocationUseCaseProtocol

    private var searchTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    init(
        conditionCode: Int? = nil,
        searchUseCase: SearchLocationsUseCaseProtocol = DIContainer.shared.makeSearchLocationsUseCase(),
        saveUseCase: SaveLocationUseCaseProtocol = DIContainer.shared.makeSaveLocationUseCase(),
        fetchSavedUseCase: FetchSavedLocationsUseCaseProtocol = DIContainer.shared.makeFetchSavedLocationsUseCase(),
        deleteUseCase: DeleteLocationUseCaseProtocol = DIContainer.shared.makeDeleteLocationUseCase()
    ) {
        self.conditionCode = conditionCode
        self.searchUseCase = searchUseCase
        self.saveUseCase = saveUseCase
        self.fetchSavedUseCase = fetchSavedUseCase
        self.deleteUseCase = deleteUseCase
        setupSearchDebounce()
    }

    // MARK: - Setup

    private func setupSearchDebounce() {
        $query
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                guard let self else { return }
                if value.count < 2 {
                    self.searchResults = []
                    self.errorMessage = nil
                } else {
                    Task { await self.performSearch(query: value) }
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Search

    private func performSearch(query: String) async {
        searchTask?.cancel()
        isSearching = true
        errorMessage = nil

        let task = Task<Void, Never> {
            do {
                let results = try await searchUseCase.execute(query: query)
                guard !Task.isCancelled else { return }
                searchResults = results
            } catch {
                guard !Task.isCancelled else { return }
                errorMessage = error.localizedDescription
                searchResults = []
            }
            isSearching = false
        }
        searchTask = task
        await task.value
    }

    // MARK: - Saved Locations

    func loadSavedLocations() {
        savedLocations = fetchSavedUseCase.execute()
    }

    func saveLocation(_ result: SearchResult) {
        guard !isSaved(result) else { return }
        saveUseCase.execute(
            SavedLocation(
                name:    result.name,
                region:  result.region,
                country: result.country,
                lat:     result.lat,
                lon:     result.lon
            )
        )
        loadSavedLocations()
    }

    func deleteLocation(at offsets: IndexSet) {
        offsets.forEach { index in
            guard index < savedLocations.count else { return }
            deleteUseCase.execute(name: savedLocations[index].name)
        }
        loadSavedLocations()
    }

    func isSaved(_ result: SearchResult) -> Bool {
        savedLocations.contains { $0.name == result.name }
    }

    var showSavedLocations: Bool { query.count < 2 }
}

// MARK: - Theme
// Uses the same condition code as HomeViewModel so the theme matches the home screen.

extension SearchViewModel {
    var theme: AppTheme { AppTheme(conditionCode: conditionCode) }

    var backgroundColor: Color    { theme.backgroundColor }
    var accentColor: Color        { theme.accentColor }
    var cardBackground: Color     { theme.cardBackground }
    var primaryTextColor: Color   { theme.primaryTextColor }
    var secondaryTextColor: Color { theme.secondaryTextColor }
    var backgroundImage: String   { theme.backgroundImage }
}
