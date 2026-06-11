//
//  SearchViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var query: String = ""
    @Published var searchResults: [SearchResult] = []
    @Published var savedLocations: [SavedLocation] = []
    @Published var isSearching: Bool = false
    @Published var errorMessage: String?

    let searchUseCase: SearchLocationsUseCaseProtocol
    let saveUseCase: SaveLocationUseCaseProtocol
    let fetchSavedUseCase: FetchSavedLocationsUseCaseProtocol
    let deleteUseCase: DeleteLocationUseCaseProtocol

    var searchTask: Task<Void, Never>?
    var cancellables = Set<AnyCancellable>()

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
    }
}
