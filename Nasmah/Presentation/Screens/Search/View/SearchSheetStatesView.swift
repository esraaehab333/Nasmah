//
//  SearchSheetStatesView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct SearchLoadingState: View {
    let vm: SearchViewModel

    var body: some View {
        VStack {
            ProgressView().tint(vm.accentColor)
            Text("Searching…")
        }
    }
}

struct SearchHintState: View {
    let vm: SearchViewModel

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(vm.primaryTextColor.opacity(0.35))

            Text("Search for a city")
                .foregroundStyle(vm.primaryTextColor.opacity(0.7))
        }
    }
}

struct SearchEmptyState: View {
    let vm: SearchViewModel

    var body: some View {
        Text("No results found")
            .foregroundStyle(vm.primaryTextColor.opacity(0.8))
    }
}

struct SearchErrorState: View {
    let vm: SearchViewModel
    let message: String

    var body: some View {
        VStack {
            Text("Search unavailable")
            Text(message)
        }
    }
}
