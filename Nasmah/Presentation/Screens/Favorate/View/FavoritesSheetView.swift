//
//  FavoritesSheetView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct FavoritesSheetView: View {
    @StateObject private var vm = SearchViewModel()
    @Environment(\.dismiss) private var dismiss
    let onCitySelected: (String) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#2d5a27").ignoresSafeArea()

                Group {
                    if vm.savedLocations.isEmpty {
                        emptyFavorites
                    } else {
                        favoritesList
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(.white)
                }
            }
            .onAppear { vm.loadSavedLocations() }
        }
    }

    // MARK: - Favorites list
    private var favoritesList: some View {
        List {
            ForEach(vm.savedLocations, id: \.name) { location in
                Button {
                    onCitySelected("\(location.latitude),\(location.longitude)")
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "location.fill")
                            .foregroundStyle(Color(hex: "#A8D5A2"))
                            .font(.system(size: 14))
                            .frame(width: 20)

                        VStack(alignment: .leading, spacing: 3) {
                            Text(location.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                            Text("\(location.region), \(location.country)")
                                .font(.system(size: 13))
                                .foregroundStyle(.white.opacity(0.6))
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 13))
                            .foregroundStyle(.white.opacity(0.3))
                    }
                    .padding(.vertical, 4)
                }
                .listRowBackground(Color.white.opacity(0.08))
                .listRowSeparatorTint(.white.opacity(0.15))
            }
            .onDelete { offsets in
                vm.deleteLocation(at: offsets)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    // MARK: - Empty state
    private var emptyFavorites: some View {
        VStack(spacing: 14) {
            Image(systemName: "heart.slash")
                .font(.system(size: 48))
                .foregroundStyle(.white.opacity(0.4))
            Text("No favorites yet")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
            Text("Search for a city and tap ♥ to save it.")
                .font(.system(size: 14))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
