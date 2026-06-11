//
//  SearchSheetResultsView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct SearchSheetResultsView: View {

    @ObservedObject var vm: SearchViewModel
    let onCitySelected: (String) -> Void

    var body: some View {

        List(vm.searchResults, id: \.id) { result in

            Button {
                onCitySelected("\(result.lat),\(result.lon)")
            } label: {

                HStack(spacing: 14) {

                    Circle()
                        .fill(vm.accentColor.opacity(0.18))
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: "location.fill")
                                .foregroundStyle(vm.accentColor)
                        )

                    VStack(alignment: .leading, spacing: 3) {
                        Text(result.name)
                            .foregroundStyle(vm.primaryTextColor)

                        Text("\(result.region), \(result.country)")
                            .foregroundStyle(vm.secondaryTextColor)
                    }

                    Spacer()

                    Button {
                        vm.saveLocation(result)
                    } label: {
                        Image(
                            systemName: vm.isSaved(result)
                            ? "heart.fill"
                            : "heart"
                        )
                        .foregroundStyle(
                            vm.isSaved(result)
                            ? vm.accentColor
                            : vm.primaryTextColor.opacity(0.4)
                        )
                        .scaleEffect(vm.isSaved(result) ? 1.1 : 1.0)
                    }
                    .buttonStyle(.plain)
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(vm.cardBackground)
                )
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}
