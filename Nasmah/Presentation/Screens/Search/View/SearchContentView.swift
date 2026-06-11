//
//  SearchContentView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct SearchContentView: View {

    @ObservedObject var vm: SearchViewModel
    @Binding var selectedCity: String

    var body: some View {

        VStack(spacing: 0) {

            SearchBar(
                text: $vm.query,
                accentColor: vm.accentColor
            )
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 8)

            Divider()
                .background(vm.primaryTextColor.opacity(0.12))

            ZStack {

                if vm.isSearching {

                    SearchLoadingView(vm: vm)

                } else if let error = vm.errorMessage {

                    SearchErrorView(
                        vm: vm,
                        message: error
                    )

                } else if vm.showSavedLocations {

                    SearchSavedListView(
                        vm: vm,
                        selectedCity: $selectedCity
                    )

                } else if vm.searchResults.isEmpty && vm.query.count >= 2 {

                    SearchEmptyResultsView(vm: vm)

                } else {

                    SearchResultsListView(
                        vm: vm,
                        selectedCity: $selectedCity
                    )
                }
            }
            .animation(.easeInOut(duration: 0.2), value: vm.isSearching)
            .animation(.easeInOut(duration: 0.2), value: vm.searchResults.count)
        }
    }
}
