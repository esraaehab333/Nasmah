//
//  SearchSheetContentView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct SearchSheetContentView: View {

    @ObservedObject var vm: SearchViewModel
    let onCitySelected: (String) -> Void

    var body: some View {

        VStack(spacing: 0) {

            SearchBar(
                text: $vm.query,
                accentColor: vm.accentColor
            )
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)

            Divider()
                .background(.white.opacity(0.12))

            ZStack {

                if vm.isSearching {

                    SearchLoadingState(vm: vm)

                } else if let error = vm.errorMessage {

                    SearchErrorState(vm: vm, message: error)

                } else if vm.showSavedLocations {

                    SearchHintState(vm: vm)

                } else if vm.searchResults.isEmpty && vm.query.count >= 2 {

                    SearchEmptyState(vm: vm)

                } else {

                    SearchSheetResultsView(
                        vm: vm,
                        onCitySelected: onCitySelected
                    )
                }
            }
            .animation(.easeInOut(duration: 0.2), value: vm.isSearching)
            .animation(.easeInOut(duration: 0.2), value: vm.searchResults.count)
        }
    }
}
