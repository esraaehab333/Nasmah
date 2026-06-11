//
//  SearchView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct SearchView: View {

    @StateObject private var vm = SearchViewModel()
    @Binding var selectedCity: String

    var body: some View {

        NavigationStack {

            ZStack {
                vm.backgroundColor.ignoresSafeArea()

                SearchContentView(
                    vm: vm,
                    selectedCity: $selectedCity
                )
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(vm.backgroundColor, for: .navigationBar)
            .onAppear {
                vm.loadSavedLocations()
            }
        }
    }
}
