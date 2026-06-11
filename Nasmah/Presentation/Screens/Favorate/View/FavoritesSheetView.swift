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
                vm.backgroundColor.ignoresSafeArea()

                Group {
                    if vm.savedLocations.isEmpty {
                        FavoritesEmptyView(vm: vm)
                    } else {
                        FavoritesListView(
                            vm: vm,
                            onCitySelected: onCitySelected
                        )
                    }
                }
                .animation(.easeInOut(duration: 0.25),
                           value: vm.savedLocations.isEmpty)
            }
            .toolbarBackground(vm.backgroundColor, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(vm.primaryTextColor.opacity(0.8))
                    .fontWeight(.medium)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    if !vm.savedLocations.isEmpty {
                        EditButton()
                            .foregroundStyle(vm.accentColor)
                    }
                }
            }
            .onAppear {
                vm.loadSavedLocations()
            }
        }
    }
}
