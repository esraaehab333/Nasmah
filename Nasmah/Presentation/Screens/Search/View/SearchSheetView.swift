//
//  SearchSheetView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct SearchSheetView: View {
    @StateObject private var vm = SearchViewModel()
    @Environment(\.dismiss) private var dismiss
    let onCitySelected: (String) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#2d5a27").ignoresSafeArea()

                VStack(spacing: 0) {
                    SearchBar(text: $vm.query)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 8)

                    if vm.isSearching {
                        ProgressView().tint(.white).padding(.top, 40)
                        Spacer()
                    } else if let error = vm.errorMessage {
                        errorState(message: error)
                    } else if vm.showSavedLocations {
                        // hint when no query yet
                        hintState
                    } else if vm.searchResults.isEmpty && vm.query.count >= 2 {
                        emptyResults
                    } else {
                        resultsList
                    }
                }
            }
            .navigationTitle("Search City")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(.white)
                }
            }
            .onAppear { vm.loadSavedLocations() }
        }
    }

    // MARK: - Results list
    private var resultsList: some View {
        List(vm.searchResults, id: \.id) { result in
            Button {
                onCitySelected("\(result.lat),\(result.lon)")
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(result.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("\(result.region), \(result.country)")
                            .font(.system(size: 13))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    Spacer()
                    Button {
                        vm.saveLocation(result)
                    } label: {
                        Image(systemName: vm.isSaved(result) ? "heart.fill" : "heart")
                            .font(.system(size: 20))
                            .foregroundStyle(
                                vm.isSaved(result)
                                    ? Color(hex: "#A8D5A2")
                                    : .white.opacity(0.6)
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.white.opacity(0.08))
            .listRowSeparatorTint(.white.opacity(0.15))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    // MARK: - Hint
    private var hintState: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.3))
            Text("Type a city name to search")
                .font(.system(size: 15))
                .foregroundStyle(.white.opacity(0.5))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Empty
    private var emptyResults: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.4))
            Text("No results for \"\(vm.query)\"")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white.opacity(0.7))
            Text("Try a different city name.")
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.4))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Error
    private func errorState(message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.5))
            Text("Search unavailable")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
            Text(message)
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
