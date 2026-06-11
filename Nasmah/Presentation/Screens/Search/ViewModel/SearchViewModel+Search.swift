//
//  SearchViewModel+Search.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation

extension SearchViewModel {

    func performSearch(query: String) async {

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
}
