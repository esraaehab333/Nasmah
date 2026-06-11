//
//  FavoritesListView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var vm: SearchViewModel
    let onCitySelected: (String) -> Void

    var body: some View {
        List {
            Section {
                ForEach(vm.savedLocations, id: \.name) { location in
                    FavoriteLocationRow(
                        location: location,
                        vm: vm
                    ) {
                        onCitySelected(
                            "\(location.latitude),\(location.longitude)"
                        )
                    }
                }
                .onDelete { offsets in
                    vm.deleteLocation(at: offsets)
                }
            } header: {
                HStack {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(vm.accentColor)

                    Text("\(vm.savedLocations.count) saved")
                        .font(.system(size: 12,
                                      weight: .semibold,
                                      design: .rounded))
                        .foregroundStyle(vm.secondaryTextColor)
                }
                .textCase(nil)
                .padding(.horizontal, 16)
                .padding(.bottom, 4)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
