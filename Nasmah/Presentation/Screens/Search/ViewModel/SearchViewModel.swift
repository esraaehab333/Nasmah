//
//  SearchViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var searchResults: [SearchResult] = []
    @Published var savedLocations: [SavedLocation] = []
    @Published var isSearching: Bool = false
    @Published var errorMessage: String?

    private let searchUseCase: SearchLocationsUseCaseProtocol
    private let saveUseCase: SaveLocationUseCaseProtocol
    private let fetchSavedUseCase: FetchSavedLocationsUseCaseProtocol
    private let deleteUseCase: DeleteLocationUseCaseProtocol

    private var searchTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    init(
        searchUseCase: SearchLocationsUseCaseProtocol = DIContainer.shared.makeSearchLocationsUseCase(),
        saveUseCase: SaveLocationUseCaseProtocol = DIContainer.shared.makeSaveLocationUseCase(),
        fetchSavedUseCase: FetchSavedLocationsUseCaseProtocol = DIContainer.shared.makeFetchSavedLocationsUseCase(),
        deleteUseCase: DeleteLocationUseCaseProtocol = DIContainer.shared.makeDeleteLocationUseCase()
    ) {
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
        searchTask = Task {
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
        await searchTask?.value
    }

    // MARK: - Saved Locations

    func loadSavedLocations() {
        savedLocations = fetchSavedUseCase.execute()
    }

    func saveLocation(_ result: SearchResult) {
        guard !isSaved(result) else { return }
        saveUseCase.execute(
            SavedLocation(
                name: result.name,
                region: result.region,
                country: result.country,
                lat: result.lat,
                lon: result.lon
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
