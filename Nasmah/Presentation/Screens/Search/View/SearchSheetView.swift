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
                vm.backgroundColor.ignoresSafeArea()

                SearchSheetContentView(
                    vm: vm,
                    onCitySelected: onCitySelected
                )
            }
            .toolbarBackground(vm.backgroundColor, for: .navigationBar)
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(vm.primaryTextColor.opacity(0.8))
                }
            }
            .onAppear {
                vm.loadSavedLocations()
            }
        }
    }
}
