//
//  SearchViewModel+Debounce.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation
import Combine

extension SearchViewModel {

    func setupSearchDebounce() {
        $query
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                guard let self else { return }

                if value.count < 2 {
                    self.searchResults = []
                    self.errorMessage = nil
                } else {
                    Task {
                        await self.performSearch(query: value)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
