//
//  SearchStatesView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct SearchLoadingView: View {
    let vm: SearchViewModel

    var body: some View {
        VStack {
            ProgressView().tint(vm.accentColor)
            Text("Searching…")
        }
    }
}

struct SearchEmptyResultsView: View {
    let vm: SearchViewModel

    var body: some View {
        Text("No results found")
            .foregroundStyle(vm.primaryTextColor)
    }
}

struct SearchErrorView: View {
    let vm: SearchViewModel
    let message: String

    var body: some View {
        Text(message)
            .foregroundStyle(vm.primaryTextColor)
    }
}

struct SearchSavedEmptyView: View {
    let vm: SearchViewModel

    var body: some View {
        Text("No saved locations")
            .foregroundStyle(vm.primaryTextColor)
    }
}
